#!/bin/bash
# This script runs when clicking the Waybar temperature module.
# It reads CPU/GPU and NVMe temperatures, shows them as desktop notifications,
# then signals Waybar to refresh the temperature icon immediately.

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

# Formats a single sensor line for the notification body.
fmt_line() {
    printf "%-22s  %s°C  —  %s" "$1" "$2" "$3"
}

# Builds a short human-friendly label for an NVMe drive, e.g. "Samsung 500GB".
nvme_label() {
    local model="$1" sectors="$2"
    # Match the start of the model string against known brand prefixes.
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
        *)                   brand="Drive"     ;;
    esac
    # Convert sector count to GB or TB.
    local size_str=""
    if [[ -n "$sectors" && "$sectors" -gt 0 ]]; then
        local size_gb=$(( sectors * 512 / 1000000000 ))
        [[ $size_gb -ge 1000 ]] && size_str="$((size_gb / 1000))TB" \
                                || size_str="${size_gb}GB"
    fi
    # Return "Brand XGB" or just "Brand" if size couldn't be determined.
    [[ -n "$size_str" ]] && echo "${brand} ${size_str}" || echo "$brand"
}

# -----------------------------------------------------------------------------
# Sensor reading
# -----------------------------------------------------------------------------
cpu_gpu_lines=()
nvme_lines=()

# CPU
for hwmon in /sys/class/hwmon/hwmon*/; do
    name=$(cat "${hwmon}name" 2>/dev/null)
    case "$name" in
        coretemp|k10temp|zenpower|cpu_thermal)
            raw=$(cat "${hwmon}temp1_input" 2>/dev/null)
            if [[ -n "$raw" ]]; then
                t=$((raw / 1000))
                cpu_gpu_lines+=("$(fmt_line "CPU: i9-10900KF" "$t" "$(describe $t)")")
                break
            fi
            ;;
    esac
done

# GPU - tries NVIDIA first, then falls back to AMD.
gpu_found=false
if command -v nvidia-smi &>/dev/null; then
    gpu=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>/dev/null | tr -d ' ')
    if [[ -n "$gpu" && "$gpu" =~ ^[0-9]+$ ]]; then
        cpu_gpu_lines+=("$(fmt_line "GPU: RTX-3070 OC" "$gpu" "$(describe $gpu)")")
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
                cpu_gpu_lines+=("$(fmt_line "GPU" "$t" "$(describe $t)")")
                break
            fi
        fi
    done
fi

# NVMe drives
for hwmon in /sys/class/hwmon/hwmon*/; do
    name=$(cat "${hwmon}name" 2>/dev/null)
    if [[ "$name" == "nvme" ]]; then
        raw=$(cat "${hwmon}temp1_input" 2>/dev/null)
        if [[ -n "$raw" ]]; then
            t=$((raw / 1000))
            hwmon_real=$(readlink -f "${hwmon%/}")   # resolve symlink to real path
            nvme_dir="${hwmon_real}/.."              # parent dir = the nvme device
            model=$(cat "${nvme_dir}/model" 2>/dev/null | sed 's/[[:space:]]*$//')
            # find the block namespace, e.g. nvme0n1
            nvme_ns=$(ls "$nvme_dir" 2>/dev/null | grep -E '^nvme[0-9]+n[0-9]+$' | head -1)
            sectors=$(cat "${nvme_dir}/${nvme_ns}/size" 2>/dev/null)
            short=$(nvme_label "$model" "$sectors")
            nvme_lines+=("$(fmt_line "NVMe: $short" "$t" "$(describe $t)")")
        fi
    fi
done

# -----------------------------------------------------------------------------
# Notifications
# -----------------------------------------------------------------------------
# Send two separate notifications so CPU/GPU and storage stay easy to scan.
notify-send -u low "󰔏  Processors" "<tt>$(printf "%s\n" "${cpu_gpu_lines[@]}")</tt>"
notify-send -u low "󰔏  Storage" "<tt>$(printf "%s\n" "${nvme_lines[@]}")</tt>"

# Refresh the Waybar temperature module after the click action.
pkill -RTMIN+11 waybar
