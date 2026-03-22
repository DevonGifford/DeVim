-- lua/custom/open_import.lua
local M = {}

local function extract_import_path_from_line(line)
  return line:match("from%s+['\"]([^'\"]+)['\"]")
      or line:match("import%s+['\"]([^'\"]+)['\"]")
end

local function open_import_path(import_path, open_cmd)
  open_cmd = open_cmd or "edit"

  local root = vim.fs.root(0, { "tsconfig.json", "package.json", ".git" }) or vim.fn.getcwd()

  if vim.startswith(import_path, "@/") then
    -- If your alias maps to /src, change this line to: root .. "/src/" ..
    import_path = root .. "/" .. import_path:sub(3)
  elseif vim.startswith(import_path, "./") or vim.startswith(import_path, "../") then
    local bufdir = vim.fn.expand("%:p:h")
    import_path = bufdir .. "/" .. import_path
  end

  local candidates = {
    import_path,
    import_path .. ".ts",
    import_path .. ".tsx",
    import_path .. ".js",
    import_path .. ".jsx",
    import_path .. "/index.ts",
    import_path .. "/index.tsx",
    import_path .. "/index.js",
    import_path .. "/index.jsx",
  }

  for _, p in ipairs(candidates) do
    if vim.fn.filereadable(p) == 1 then
      vim.cmd(open_cmd .. " " .. vim.fn.fnameescape(p))
      return true
    end
  end

  vim.notify("Could not resolve import: " .. import_path, vim.log.levels.ERROR)
  return false
end

local function find_import_for_symbol_in_buffer(symbol)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for _, line in ipairs(lines) do
    if line:find("import", 1, true) and line:find("from", 1, true) then
      local path = extract_import_path_from_line(line)
      if path then
        local default_name = line:match("^%s*import%s+([%w_]+)%s+from%s+")
        if default_name == symbol then return path end

        local ns_name = line:match("^%s*import%s+%*%s+as%s+([%w_]+)%s+from%s+")
        if ns_name == symbol then return path end

        local named_block = line:match("^%s*import%s+%{(.-)%}%s+from%s+")
        if named_block then
          for part in named_block:gmatch("[^,]+") do
            local name, alias = part:match("^%s*([%w_]+)%s+as%s+([%w_]+)%s*$")
            name = name or part:match("^%s*([%w_]+)%s*$")
            alias = alias or part:match("^%s*([%w_]+)%s*$")

            if name == symbol or alias == symbol then
              return path
            end
          end
        end
      end
    end
  end

  return nil
end

function M.go(open_cmd)
  local line = vim.api.nvim_get_current_line()

  -- If you're on an import line, open it directly
  local direct = extract_import_path_from_line(line)
  if direct then
    open_import_path(direct, open_cmd)
    return
  end

  -- Otherwise: resolve via the symbol under cursor
  local symbol = vim.fn.expand("<cword>")
  if not symbol or symbol == "" then
    vim.notify("No symbol under cursor", vim.log.levels.WARN)
    return
  end

  local path = find_import_for_symbol_in_buffer(symbol)
  if not path then
    vim.notify("No import found in this file for: " .. symbol, vim.log.levels.WARN)
    return
  end

  open_import_path(path, open_cmd)
end

return M
