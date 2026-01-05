#!/bin/bash
# This script runs on an interval (every 5 minutes by default, set in config.jsonc).
# It reads temperatures from hardware sensors, then prints a single line of JSON
# that Waybar parses to update the bar icon. 

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
# Returns a human-readable label for a given temperature in °C.
describe() {
    local t=$1
    if   [[ $t -lt 45 ]]; then echo "cool"
    elif [[ $t -lt 55 ]]; then echo "fine"
    elif [[ $t -lt 70 ]]; then echo "warm"
    elif [[ $t -lt 80 ]]; then echo "hot"
    else echo "too hot"
    fi
}

# Returns a CSS class name based on temperature. 
get_class() {
    local t=$1
    if   [[ $t -lt 60 ]]; then echo "cool"
    elif [[ $t -lt 70 ]]; then echo "warm"
    elif [[ $t -lt 80 ]]; then echo "hot"
    else echo "critical"
    fi
}

# Formats a single sensor line for the tooltip.
fmt_line() {
    printf "%-22s  %s°C  —  %s" "$1" "$2" "$3"
}

# Builds a short human-friendly label for an NVMe drive, e.g. "Samsung 500GB".
nvme_label() {
    local model="$1" sectors="$2"
    # Match the start of the model string against known brand prefixes
    local brand
    case "$model" in
        Samsung*)            brand="Samsung"   ;;
        WDC*|WD\ *)          brand="WD"        ;;
        PNY*)                brand="PNY"       ;;
        SSDPR*|Goodram*)     brand="Goodram"   ;;
        Patriot*)            brand="Patriot"   ;;
        Kingston*|SA[0-9]*)  brand="Kingston"  ;;
        CT*|Crucial*)        brand="Crucial"   ;;
        Sabrent*)            brand="Sabrent"   ;;
        SK\ *|HFS*)          brand="SK Hynix"  ;;
        Corsair*)            brand="Corsair"   ;;
        INTEL*|Intel*)       brand="Intel"     ;;
        TEAM*)               brand="TeamGroup" ;;
        Micron*)             brand="Micron"    ;;
        *)                   brand="Drive"     ;; # fallback if brand is unknown
    esac
    # Convert sector count to GB or TB (manufacturers use 1,000,000,000 bytes = 1GB)
    local size_str=""
    if [[ -n "$sectors" && "$sectors" -gt 0 ]]; then
        local size_gb=$(( sectors * 512 / 1000000000 ))
        [[ $size_gb -ge 1000 ]] && size_str="$((size_gb / 1000))TB" \
                                || size_str="${size_gb}GB"
    fi
    # Return "Brand XGB" or just "Brand" if size couldn't be determined
    [[ -n "$size_str" ]] && echo "${brand} ${size_str}" || echo "$brand"
}


# -----------------------------------------------------------------------------
# Sensor readings
# -----------------------------------------------------------------------------
# Linux exposes hardware sensors via /sys/class/hwmon/. Each hwmon directory
# represents one hardware monitor chip. 
lines=()
max_temp=0

# CPU
for hwmon in /sys/class/hwmon/hwmon*/; do
    name=$(cat "${hwmon}name" 2>/dev/null)
    case "$name" in
        coretemp|k10temp|zenpower|cpu_thermal)
            raw=$(cat "${hwmon}temp1_input" 2>/dev/null)
            if [[ -n "$raw" ]]; then
                t=$((raw / 1000))
                lines+=("$(fmt_line "CPU: i9-10900KF" "$t" "$(describe $t)")")
                [[ $t -gt $max_temp ]] && max_temp=$t
                break  # stop after finding the first CPU sensor
            fi
            ;;
    esac
done

# GPU — tries NVIDIA first via nvidia-smi then falls back to AMD via the amdgpu hwmon driver
gpu_found=false
if command -v nvidia-smi &>/dev/null; then
    gpu=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>/dev/null | tr -d ' ')
    if [[ -n "$gpu" && "$gpu" =~ ^[0-9]+$ ]]; then
        lines+=("$(fmt_line "GPU: RTX-3070 OC" "$gpu" "$(describe $gpu)")")
        [[ $gpu -gt $max_temp ]] && max_temp=$gpu
        gpu_found=true
    fi
fi

if [[ "$gpu_found" == false ]]; then
    for hwmon in /sys/class/hwmon/hwmon*/; do
        name=$(cat "${hwmon}name" 2>/dev/null)
        if [[ "$name" == "amdgpu" ]]; then
            raw=$(cat "${hwmon}temp1_input" 2>/dev/null)
            if [[ -n "$raw" ]]; then
                t=$((raw / 1000))
                lines+=("$(fmt_line "GPU" "$t" "$(describe $t)")")
                [[ $t -gt $max_temp ]] && max_temp=$t
                break
            fi
        fi
    done
fi

# NVMe drives — loops all hwmon chips, picks the ones named "nvme"
# For each drive, we resolve the symlink to find the actual device directory,
# then read the model name and block device size from sibling sysfs entries
for hwmon in /sys/class/hwmon/hwmon*/; do
    name=$(cat "${hwmon}name" 2>/dev/null)
    if [[ "$name" == "nvme" ]]; then
        raw=$(cat "${hwmon}temp1_input" 2>/dev/null)
        if [[ -n "$raw" ]]; then
            t=$((raw / 1000))
            hwmon_real=$(readlink -f "${hwmon%/}")   # resolve symlink to real path
            nvme_dir="${hwmon_real}/.."              # parent dir = the nvme device
            model=$(cat "${nvme_dir}/model" 2>/dev/null | sed 's/[[:space:]]*$//')
            # find the block namespace (e.g. nvme0n1) to read capacity from
            nvme_ns=$(ls "$nvme_dir" 2>/dev/null | grep -E '^nvme[0-9]+n[0-9]+$' | head -1)
            sectors=$(cat "${nvme_dir}/${nvme_ns}/size" 2>/dev/null)
            short=$(nvme_label "$model" "$sectors")
            lines+=("$(fmt_line "NVMe: $short" "$t" "$(describe $t)")")
            [[ $t -gt $max_temp ]] && max_temp=$t
        fi
    fi
done


# -----------------------------------------------------------------------------
# JSON output
# Waybar expects a single line of JSON from "return-type": "json" modules.
# The class drives the CSS color, text is the bar icon, tooltip is on hover.
# -----------------------------------------------------------------------------
class=$(get_class $max_temp)
tooltip=""
first=true
for line in "${lines[@]}"; do
    if $first; then
        tooltip="$line"
        first=false
    else
        tooltip="${tooltip}\n${line}"
    fi
done

printf '{"text": "󰔏", "class": "%s", "tooltip": "%s"}\n' "$class" "$tooltip"
