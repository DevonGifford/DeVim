# Neovim Keybindings & Config Cheat Sheet

---

## Navigation

| Shortcut          | Action                                                 |
| ----------------- | ------------------------------------------------------ |
| `n` / `N`         | Next / Prev search + center screen (`nzzzv` / `Nzzzv`) |
| `<C-d>` / `<C-u>` | Half page down / up + center screen                    |
| `<C-h>` / `<C-l>` | Move left / right (Vim + Tmux/Yabai)                   |
| `<C-j>` / `<C-k>` | Move down / up (Vim + Tmux/Yabai)                      |

## Tabs & Splits

| Shortcut                 | Action                            |
| ------------------------ | --------------------------------- |
| `<Leader>to`             | Open new tab                      |
| `<Leader>tx`             | Close current tab                 |
| `<Leader>tn` / `<Tab>`   | Next tab (Bufferline/tabnext)     |
| `<Leader>tp` / `<S-Tab>` | Previous tab (Bufferline/tabprev) |
| `<Leader>sv`             | Vertical split                    |
| `<Leader>sh`             | Horizontal split                  |
| `<Leader>se`             | Equalize splits                   |
| `<Leader>sx`             | Close split                       |
| `<Leader><Right>`        | Widen split                       |
| `<Leader><Left>`         | Narrow split                      |

## Files, Buffers, and Explorer

| Shortcut          | Action                                   |
| ----------------- | ---------------------------------------- |
| `<Leader>f`       | Reveal file in NvimTree                  |
| `;f`              | Telescope find files                     |
| `<C-b>`           | Open Oil file explorer                   |
| `<Leader><Space>` | Telescope buffers                        |
| `<Leader>/`       | Telescope fuzzy search in current buffer |

## Import Jump (Custom)

| Shortcut      | Action                       |
| ------------- | ---------------------------- |
| `<Leader>go`  | Go to import target          |
| `<Leader>gos` | Go to import target (vsplit) |
| `<Leader>goh` | Go to import target (split)  |
| `<Leader>got` | Go to import target (tab)    |

## Diagnostics

| Shortcut    | Action                              |
| ----------- | ----------------------------------- |
| `[d` / `]d` | Prev / Next diagnostic (with float) |
| `<Leader>e` | Diagnostic float                    |
| `<Leader>q` | Diagnostics list (loclist)          |

## Telescope

| Shortcut                    | Action                                  |
| --------------------------- | --------------------------------------- |
| `<Leader>sf` / `<Leader>sg` | Find files / Live grep                  |
| `<Leader>sd` / `<Leader>sr` | Diagnostics picker / Resume last picker |
| `<Leader>?`                 | Show keymap cheatsheet (which-key)      |

## LSP

| Shortcut     | Action                            |
| ------------ | --------------------------------- |
| `gd`         | Go to definition (Telescope)      |
| `gr`         | Find references (Telescope)       |
| `gI`         | Go to implementation (Telescope)  |
| `<Leader>D`  | Type definition (Telescope)       |
| `<Leader>ds` | Document symbols (Telescope)      |
| `<Leader>ws` | Workspace symbols (Telescope)     |
| `K`          | Hover                             |
| `<C-k>`      | Signature help                    |
| `<Leader>rn` | Rename (LSP; in LSP buffers)      |
| `<Leader>ca` | Code actions                      |
| `<Leader>th` | Toggle inlay hints (if supported) |

## Refactor

| Shortcut             | Action                                     |
| -------------------- | ------------------------------------------ |
| `<Leader>rn`         | Incremental rename (`:IncRename` fallback) |
| `<Leader>r` (visual) | Refactoring menu                           |

## Treesitter Selection

| Shortcut    | Action                    |
| ----------- | ------------------------- |
| `<C-Space>` | Start / expand selection  |
| `<C-s>`     | Expand selection to scope |
| `<M-Space>` | Shrink selection          |

## Completion (Insert Mode)

| Shortcut          | Action                        |
| ----------------- | ----------------------------- |
| `<C-n>` / `<C-p>` | Next / Previous item          |
| `<C-d>` / `<C-f>` | Scroll docs                   |
| `<C-Space>`       | Trigger completion            |
| `<CR>`            | Confirm selection             |
| `<S-Tab>`         | Prev item / snippet jump back |

## Copilot (Insert Mode)

| Shortcut          | Action                     |
| ----------------- | -------------------------- |
| `<C-l>`           | Accept suggestion          |
| `<M-]>` / `<M-[>` | Next / Previous suggestion |
| `<C-]>`           | Dismiss suggestion         |

## Flash

| Shortcut               | Action              |
| ---------------------- | ------------------- |
| `s`                    | Flash jump          |
| `S`                    | Flash Treesitter    |
| `r` (operator)         | Remote flash        |
| `R` (operator/visual)  | Treesitter search   |
| `<C-s>` (command-line) | Toggle Flash search |

## DAP

| Shortcut     | Action            |
| ------------ | ----------------- |
| `<Leader>dl` | Toggle DAP UI     |
| `<Leader>dc` | Continue          |
| `<Leader>db` | Toggle breakpoint |
| `<Leader>dr` | Open REPL         |
| `<Leader>ds` | Step over         |
| `<Leader>di` | Step into         |

## Git

| Shortcut | Action     |
| -------- | ---------- |
| `;c`     | LazyGit UI |

| Command                                | Action                  |
| -------------------------------------- | ----------------------- |
| `:Git` / `:Git add %` / `:Gwrite`      | Git status / stage file |
| `:Gread`                               | Restore from HEAD       |
| `:Git commit` / `:Gcommit`             | Git commit UI           |
| `:Git blame` / `:Gblame`               | Show blame info         |
| `:Gdiffsplit` / `:Gdiffsplit <branch>` | Diff vs HEAD / branch   |
| `:Git log`                             | Show Git log            |
| `:Git push` / `:Git pull`              | Push / pull changes     |

## Oil (File Explorer)

| Shortcut | Action                 |
| -------- | ---------------------- |
| `<CR>`   | Open                   |
| `<C-s>`  | Open in vertical split |
| `<C-t>`  | Open in tab            |
| `<C-p>`  | Preview                |
| `<C-c>`  | Close                  |
| `-`      | Parent directory       |
| `_`      | Open CWD               |
| `` ` ``  | Set CWD                |
| `~`      | Set CWD (tab scope)    |
| `gs`     | Change sort            |
| `gx`     | Open external          |
| `g.`     | Toggle hidden          |
| `g\`     | Toggle trash           |

## NvimTree (File Explorer)

| Shortcut | Action           |
| -------- | ---------------- |
| `t`      | Open node in tab |

## Misc

| Shortcut                  | Action                                      |
| ------------------------- | ------------------------------------------- |
| `<Leader>+` / `<Leader>-` | Increment / Decrement number                |
| `<C-a>`                   | Select all                                  |
| `<S-Tab>` (insert)        | Un-indent (when completion is not active)   |
| `<Leader>hex`             | Convert hex color to rgb/rgba (`:HexToRgb`) |

## Auto Format on Save

| Language                                           | Tool                                |
| -------------------------------------------------- | ----------------------------------- |
| CSS / SCSS / LESS / SASS                           | `stylelint --fix` (if config found) |
| Rust                                               | `cargo fmt`                         |
| Go                                                 | `gofmt -w`                          |
| JS / TS / JSON / YAML / HTML / MD / MDX / CSS, etc | `prettier` (config if found)        |
