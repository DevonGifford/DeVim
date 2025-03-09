local config = {disable_when_zoomed = false, keybindings = {}}

local yabai_directions = {
    ['h'] = 'west',
    ['j'] = 'south',
    ['k'] = 'north',
    ['l'] = 'east'
}

local tmux_directions = {
    ['p'] = 'l',
    ['h'] = 'L',
    ['j'] = 'D',
    ['k'] = 'U',
    ['l'] = 'R',
    ['n'] = 't:.+'
}

local function tmux_command(command)
    local tmux_socket = vim.fn.split(vim.env.TMUX, ',')[1]
    return vim.fn.system("tmux -S " .. tmux_socket .. " " .. command)
end

local function tmux_change_pane(direction)
    tmux_command("select-pane -" .. tmux_directions[direction])
end

local function is_tmux_pane_zoomed()
    return tmux_command("display-message -p '#{window_zoomed_flag}'") == "1\n"
end

local function should_tmux_control(is_same_winnr, disable_nav_when_zoomed)
    if is_tmux_pane_zoomed() and disable_nav_when_zoomed then return false end
    return is_same_winnr
end

local function vim_navigate(direction)
    if direction == 'n' then
        pcall(vim.cmd, 'wincmd w')
    elseif pcall(vim.cmd, 'wincmd ' .. direction) then
        -- success
    else
        -- error, cannot wincmd from the command-line window
        vim.cmd(
            [[ echohl ErrorMsg | echo 'E11: Invalid in command-line window; <CR> executes, CTRL-C quits' | echohl None ]])
    end
end

-- whether tmux should control the previous pane switching or no
--
-- by default it's true, so when you enter a new vim instance and
-- try to switch to a previous pane, tmux should take control
local tmux_control = true

local function tmux_navigate(direction)
    if direction == 'n' then

        local is_last_win = (vim.fn.winnr() == vim.fn.winnr('$'))

        if is_last_win then
            pcall(vim.cmd, 'wincmd t')
            tmux_change_pane(direction)
        else
            vim_navigate(direction)
        end

    elseif direction == 'p' then

        -- if the last pane was a tmux pane, then we need to handle control
        -- to tmux; otherwise, just issue a last pane command in vim
        if tmux_control == true then
            tmux_change_pane(direction)
        elseif tmux_control == false then
            vim_navigate(direction)
        end

    else

        -- save the current window number to check later whether we're in the same
        -- window after issuing a vim navigation command
        local winnr = vim.fn.winnr()

        -- try to navigate normally
        vim_navigate(direction)

        -- if we're in the same window after navigating
        local is_same_winnr = (winnr == vim.fn.winnr())

        -- if we're in the same window and zoom is not disabled, tmux should take control
        if should_tmux_control(is_same_winnr, config.disable_when_zoomed) then
            tmux_change_pane(direction)
            tmux_control = true
        else
            tmux_control = false
        end
    end
end

local function yabai_navigate(direction)
    local yabai_command = "yabai -m window --focus " ..
                              yabai_directions[direction]
    vim.fn.system(yabai_command)
end

local bind = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
end

local function create_command(command_name, func, direction)
    -- use nvim's user command api to create commands
    vim.api.nvim_create_user_command(command_name,
                                     function(...) func(direction) end, {})
end

local navigate = nil
if vim.env.TMUX ~= nil then
    navigate = tmux_navigate
elseif vim.fn.executable('yabai') == 1 then
    navigate = yabai_navigate
else
    navigate = vim_navigate
end

create_command("NvimTmuxNavigateLeft", navigate, 'h')
create_command("NvimTmuxNavigateDown", navigate, 'j')
create_command("NvimTmuxNavigateUp", navigate, 'k')
create_command("NvimTmuxNavigateRight", navigate, 'l')
create_command("NvimTmuxNavigateLastActive", navigate, 'p')

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    desc = 'Better mappings for tmux navigation',
    callback = function()
        bind('<C-h>', ":NvimTmuxNavigateLeft<CR>")
        bind('<C-j>', ":NvimTmuxNavigateDown<CR>")
        bind('<C-k>', ":NvimTmuxNavigateUp<CR>")
        bind('<C-l>', ":NvimTmuxNavigateRight<CR>")
    end
})
