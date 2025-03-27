local autocmd = "BufWritePost"

local function file_exists(filepath)
    local f = io.open(filepath, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function folder_exists(folderpath)
    local f = io.open(folderpath, "r")
    if f ~= nil then
        io.close(f)
        return true
    end
    return false
end

local function isempty(s) return s == nil or s == '' end

local prettier_config_file = ""
local stylelint_config_file = ""

local function findPrettierConfig()
    local prettier_files = {
        ".prettierrc", ".prettierrc.json", ".prettierrc.yaml",
        ".prettierrc.yml", ".prettierrc.js", "prettier.config.mjs",
        "prettier.config.js"
    }

    local dir = vim.fn.getcwd()

    for _, file in ipairs(prettier_files) do
        local path = dir .. '/' .. file
        if file_exists(path) then
            prettier_config_file = path
            return
        end
    end

    if folder_exists(dir .. "/project") then
        for _, file in ipairs(prettier_files) do
            local path = dir .. "/project/" .. file
            if file_exists(path) then
                prettier_config_file = path
                return
            end
        end
    end
end

local function findStylelintConfig()
    local stylelint_files = {
        ".stylelintrc", ".stylelintrc.json", ".stylelintrc.yaml",
        ".stylelintrc.yml", ".stylelintrc.js", "stylelint.config.mjs",
        "stylelint.config.js"
    }

    local dir = vim.fn.getcwd()

    for _, file in ipairs(stylelint_files) do
        local path = dir .. '/' .. file
        if file_exists(path) then
            stylelint_config_file = path
            return
        end
    end

    if folder_exists(dir .. "/project") then
        for _, file in ipairs(stylelint_files) do
            local path = dir .. "/project/" .. file
            if file_exists(path) then
                stylelint_config_file = path
                return
            end
        end
    end
end

vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        findPrettierConfig()
        findStylelintConfig()
    end
})

vim.api.nvim_create_autocmd("DirChanged", {
    pattern = "*",
    callback = function()
        findPrettierConfig()
        findStylelintConfig()
    end
})

local function findCompileCommands()
    local dir = vim.fn.getcwd()

    local path = dir .. '/compile_commands.json'
    if file_exists(path) then return path end

    return nil
end

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatCssOnSave", {clear = true}),
    pattern = "*.{css,scss,less,sass}",
    callback = function()
        if stylelint_config_file then
            vim.cmd("silent! !stylelint --config " .. stylelint_config_file ..
                        " --fix %")
            vim.cmd("edit!")
        end
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatCOnSave", {clear = true}),
    pattern = "*.{c,h,cpp,hpp}",
    callback = function()
        local compile_commands = findCompileCommands()
        if compile_commands then
            vim.cmd(
                "silent! !clang-format -assume-filename=compile_commands.json -style=file -i %")
            vim.cmd("edit!")
        end
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatLuaOnSave", {clear = true}),
    pattern = "*.lua",
    callback = function()
        vim.cmd("silent! !lua-format -i % --tab-width 4 --column-limit 80")
        vim.cmd("edit!")
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatRustOnSave", {clear = true}),
    pattern = "*.rs",
    callback = function()
        vim.cmd("silent! !cargo fmt")
        vim.cmd("edit!")
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatGoOnSave", {clear = true}),
    pattern = "*.go",
    callback = function()
        vim.cmd("silent! !gofmt -w %")
        vim.cmd("edit!")
    end
})

vim.api.nvim_create_autocmd(autocmd, {
    group = vim.api.nvim_create_augroup("FormatPrettierOnSave", {clear = true}),
    pattern = "*.{js,jsx,ts,tsx,css,scss,less,sass,html,json,yaml,yml,md,markdown,mdx}",
    callback = function()
        if isempty(prettier_config_file) then
            vim.cmd("silent! !prettier % --print-width 80 --tab-width 4 --write")
        else
            vim.cmd("silent! !prettier % --config " .. prettier_config_file ..
                        " --write")
        end
    end
})
