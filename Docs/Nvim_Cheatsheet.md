
# 🧠 Neovim Keybindings & Config Cheat Sheet
---
### Navigation
| Shortcut          | Action                                                 |
| ----------------- | ------------------------------------------------------ |
| `n` / `N`         | Next / Prev search + center screen (`nzzzv` / `Nzzzv`) |
| `<C-d>` / `<C-u>` | Half page down / up + center screen                    |
| `<C-h>` / `<C-l>` | Move left / right (Vim + Tmux)                         |
| `<C-j>` / `<C-k>` | Move down / up (Vim + Tmux)                            |
### Tabs & Splits
| Shortcut | Action |
|----------|--------|
| `<Leader>to` | Open new tab |
| `<Leader>tx` | Close current tab |
| `<Leader>tn` / `<Tab>` | Next tab |
| `<Leader>tp` / `<S-Tab>` | Previous tab |
| `<Leader>sv` | Vertical split |
| `<Leader>sh` | Horizontal split |
| `<Leader>se` | Equalize splits |
| `<Leader>sx` | Close split |
| `<Leader>+` / `<Leader>-` | Resize window (grow / shrink) |
## 📦 Misc & Quality of Life
| Shortcut | Action |
|----------|--------|
| `<Leader>f` | Reveal file in NvimTree |
| `<C-b>` | Open Oil file explorer |
| `<Leader>w` / `<Leader>q` / `<Leader>Q` | Save / Quit / Quit all |
| `<Leader>+` / `<Leader>-` | Increment / Decrement number |
| `<C-a>` | Select all |
| `<S-Tab>` | Un-indent (Insert mode) |
## 🚨 Diagnostics
| Shortcut    | Action                 |
| ----------- | ---------------------- |
| `<Leader>e` | Diagnostic float       |
| `<Leader>q` | Diagnostics list       |
| `<Leader>t` | Diagnostic info float  |
| `[d` / `]d` | Prev / Next diagnostic |
## 🔭 Telescope & Utils
| Shortcut                        | Action                                  |
| ------------------------------- | --------------------------------------- |
| `<Leader>sf` / `<Leader>sg`     | Find files / Live grep                  |
| `<Leader>sd` / `<Leader>sr`     | Diagnostics picker / Resume last picker |
| `<Leader>/` / `<Leader><Space>` | Buffer fuzzy search / buffer list       |
| `<Leader>?`                     | Show keymap cheatsheet                  |
| `;c` / `:LazyGit`               | Open LazyGit UI                         |
## 🛠 Dev Tools: LSP, Treesitter, Refactor
| Shortcut                    | Action                                      |
| --------------------------- | ------------------------------------------- |
| `<Leader>gd` / `<Leader>gr` | Go to definition / Find references          |
| `<Leader>rn` / `<Leader>ca` | Rename / Code actions                       |
| `<Leader>rf` / `<Leader>rs` | Refactor / Refactor options                 |
| `<C-Space>` / `<M-Space>`   | Start/extend or shrink Treesitter selection |
| `<C-s>`                     | Increment Treesitter scope                  |
## 🔧 Git Integration
### Telescope Git
| Shortcut     | Action                 |
| ------------ | ---------------------- |
| `<Leader>gs` | Git status (Telescope) |
| `<Leader>gc` | Git commits            |
| `<Leader>gb` | Git branches           |
| `<Leader>gl` | Git commits (buffer)   |
### Fugitive + Gitsigns
| Command                                                               | Action                  |
| --------------------------------------------------------------------- | ----------------------- |
| `:Git` / `:Git add %` / `:Gwrite`                                     | Git status / stage file |
| `:Gread`                                                              | Restore from HEAD       |
| `:Git commit` / `:Gcommit`                                            | Git commit UI           |
| `:Git blame` / `:Gblame`                                              | Show blame info         |
| `:Gdiffsplit` / `:Gdiffsplit branchname`                              | Diff vs HEAD / branch   |
| `:Git log`                                                            | Show Git log            |
| `:Git push` / `:Git pull`                                             | Push / pull changes     |
| `<Leader>gt` / `:Gitsigns toggle_current_line_blame`                  | Toggle inline blame     |
| `:Gitsigns blame_line` / `preview_hunk` / `stage_hunk` / `reset_hunk` | Gitsigns hunk actions   |
| `:Gitsigns next_hunk` / `prev_hunk`                                   | Navigate hunks          |
## 🧼 Auto Format on Save
| Language  | Tool           |
| --------- | -------------- |
| CSS/SASS  | `stylelint`    |
| C/C++     | `clang-format` |
| Lua       | `lua-format`   |
| Rust      | `cargo fmt`    |
| Go        | `gofmt`        |
| JS/TS/etc | `prettier`     |
