-- Format-on-save + config discovery (Prettier/Stylelint)
local AUTOCMD = "BufWritePost"

-- ----------------------------
-- Tiny utils
-- ----------------------------
local function isempty(s)
  return s == nil or s == ""
end

local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

local function folder_exists(path)
  -- simplest "exists" check you were using (kept)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

-- ----------------------------
-- Project config discovery
-- ----------------------------
local prettier_config_file = ""
local stylelint_config_file = ""

local PRETTIER_FILES = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  ".prettierrc.js",
  "prettier.config.mjs",
  "prettier.config.js",
}

local STYLELINT_FILES = {
  ".stylelintrc",
  ".stylelintrc.json",
  ".stylelintrc.yaml",
  ".stylelintrc.yml",
  ".stylelintrc.js",
  "stylelint.config.mjs",
  "stylelint.config.js",
}

local function find_config(files)
  local dir = vim.fn.getcwd()

  -- Look in repo root
  for _, file in ipairs(files) do
    local path = dir .. "/" .. file
    if file_exists(path) then
      return path
    end
  end

  -- Optional: look in /project
  local project_dir = dir .. "/project"
  if folder_exists(project_dir) then
    for _, file in ipairs(files) do
      local path = project_dir .. "/" .. file
      if file_exists(path) then
        return path
      end
    end
  end

  return ""
end

local function refresh_tool_configs()
  prettier_config_file = find_config(PRETTIER_FILES)
  stylelint_config_file = find_config(STYLELINT_FILES)
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
  pattern = "*",
  callback = refresh_tool_configs,
})

-- ----------------------------
-- compile_commands.json helper (C/C++)
-- ----------------------------
local function has_compile_commands()
  local dir = vim.fn.getcwd()
  return file_exists(dir .. "/compile_commands.json")
end

-- ----------------------------
-- autocmd helpers
-- ----------------------------
local group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

local function run_cmd_and_reload(cmd)
  vim.cmd("silent! " .. cmd)
  vim.cmd("edit!")
end

local function format_on_save(pattern, cmd_or_fn)
  vim.api.nvim_create_autocmd(AUTOCMD, {
    group = group,
    pattern = pattern,
    callback = function()
      local cmd = type(cmd_or_fn) == "function" and cmd_or_fn() or cmd_or_fn
      if isempty(cmd) then
        return
      end
      run_cmd_and_reload(cmd)
    end,
  })
end

local function format_on_save_when(pattern, when_fn, cmd_fn)
  vim.api.nvim_create_autocmd(AUTOCMD, {
    group = group,
    pattern = pattern,
    callback = function()
      if not when_fn() then
        return
      end
      local cmd = cmd_fn()
      if isempty(cmd) then
        return
      end
      run_cmd_and_reload(cmd)
    end,
  })
end

-- ----------------------------
-- Formatters
-- ----------------------------

-- CSS / SCSS / etc via stylelint (only if config was found)
format_on_save_when("*.{css,scss,less,sass}", function()
  return not isempty(stylelint_config_file)
end, function()
  return "!stylelint --config " .. stylelint_config_file .. " --fix %"
end)

-- Rust
format_on_save("*.rs", "!cargo fmt")

-- Go
format_on_save("*.go", "!gofmt -w %")

-- Prettier for web stuff (uses config if found)
format_on_save("*.{js,jsx,ts,tsx,css,scss,less,sass,html,json,yaml,yml,md,markdown,mdx}", function()
  if isempty(prettier_config_file) then
    return "!prettier % --print-width 80 --tab-width 4 --write"
  end
  return "!prettier % --config " .. prettier_config_file .. " --write"
end)

-- ----------------------------
-- Lua formatting
-- ----------------------------
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = group,
--   pattern = "*.lua",
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })

