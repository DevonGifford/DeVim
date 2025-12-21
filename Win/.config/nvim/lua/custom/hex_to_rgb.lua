function hex_to_rgb_or_rgba(hex_color)
    hex_color = hex_color:gsub("#", "")

    if #hex_color ~= 6 and #hex_color ~= 8 then
        error("Hex-Farbwert muss 6 (RGB) oder 8 (RGBA) Zeichen lang sein.")
    end

    local r = tonumber(hex_color:sub(1, 2), 16)
    local g = tonumber(hex_color:sub(3, 4), 16)
    local b = tonumber(hex_color:sub(5, 6), 16)

    if #hex_color == 8 then
        local a = tonumber(hex_color:sub(7, 8), 16) / 255
        return string.format("rgba(%d %d %d / %.2f)", r, g, b, a)
    else
        return string.format("rgb(%d %d %d)", r, g, b)
    end
end

vim.api.nvim_create_user_command("HexToRgb", function()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    local hex_color = table.concat(lines, ""):sub(start_pos[3], end_pos[3])

    local result, err = hex_to_rgb_or_rgba(hex_color)

    if not result then
        vim.notify(err, "error")
        return
    end

    vim.api.nvim_buf_set_text(0, start_pos[2] - 1, start_pos[3] - 1,
                              start_pos[2] - 1, end_pos[3], {result})
    vim.notify(result, "info")
end, {range = true})

local bind = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
end

bind("<leader>hex", ":HexToRgb<CR>")
