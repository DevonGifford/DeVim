# **GENERAL TERMINAL THINGS**

# 🔁  `fzf --zsh`
| Command                | Description                          |
| ---------------------- | ------------------------------------ |
| `Ctrl + T`             | Trigger file search (anywhere, any file) |
| `Alt + C`              | Fuzzy jump to a directory    |
| `Ctrl + R`             | Fuzzy search your command history   |

---
## 🧭 Zoxide – Smart `cd`

| command                | Description                          |
| ---------------------- | ------------------------------------ |
| `z my-folder`          | Jump to folder you've visited before |
| `z src`                | Fuzzy-jump to any path with "src"    |
| `zi` _(if you add it)_ | Fuzzy interactive jump using `fzf`   |

---
## 📁 Eza – Better ls

| Command        | What it does                                 |
| -------------- | -------------------------------------------- |
| `ls`           | Colorful, iconified listing (alias to `eza`) |
| `eza -T`       | Tree view of folder                          |
| `eza -l --git` | Long view with Git info                      |

---
## 🔍 FZF – Fuzzy Finder

|Shortcut|Action|
|---|---|
|`Ctrl + T`|Fuzzy find files (inserts into CLI)|
|`Alt + C`|Fuzzy jump to directory|
|`Ctrl + R`|Search command history|
|`fzf`|Run fuzzy finder in current folder|
|`nvim $(fzf)`|Open fuzzy-picked file in `nvim`|

---
## 🧪 fzf-git.sh – Git with Fuzz
> Use these inside a Git repo.

| Command          | What it does                        |
| ---------------- | ----------------------------------- |
| `fzf-git-branch` | Fuzzy-checkout branches             |
| `fzf-git-log`    | Fuzzy-view Git log w/ previews      |
| `fzf-git-status` | Fuzzy view of `git status`          |
| `fzf-git-add`    | Interactively stage files           |
| `fzf-git-diff`   | Fuzzy-select and preview file diffs |
| `fzf-git-stash`  | Fuzzy view/apply stashes            |
| `fzf-git-tag`    | Checkout Git tags                   |
| `fzf-git-remote` | Switch between Git remotes          |

---
## 🐱 Bat – Better Cat
> Used automatically in FZF previews.

| Command          | What it does                       |
| ---------------- | ---------------------------------- |
| `bat file.js`    | View file with syntax highlighting |
| `bat -n file.js` | With line numbers                  |

---
## 📘 TLDR

| Command          | What it does                        |
| ---------------- | ----------------------------------- |
| `tldr <command>` | Show quick cheatsheet for a command |
| `tldr tar`       | Example: how to use `tar`           |
| `tldr git log`   | Example: `git log` use cases        |
| `tldr`           | Show help for `tldr` itself         |

---
## 🌱 NVM – Node Version Manager

| Command          | What it does                 |
| ---------------- | ---------------------------- |
| `nvm ls`         | List installed Node versions |
| `nvm install 18` | Install Node 18              |
| `nvm use 18`     | Switch to Node 18            |


<br/>
<br/>
<br/>
<br/>

# **🎛️ tmux – Terminal Multiplexer Things**
> Prefix is remapped to `Cmd + A` (instead of default `Ctrl + B`)
### 📦 Install TPM
```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
### 📥 Install Plugins
Inside tmux:
```
Cmd + A  I
```
---
## 🔁 Reload Config
```
Cmd + A  R
```

---
## 📂 Session Management

| Command                          | Description             |
| -------------------------------- | ----------------------- |
| `tmux ls`                        | List all sessions       |
| `tmux attach -t mysession`       | Attach to a session     |
| `tmux new -s mysession`          | Create a new session    |
| `tmux kill-session -t mysession` | Kill a specific session |
| `tmux kill-server`               | Kill all sessions       |
| `Cmd + A d`                      | Detach from session     |

---
## 🪟 Window Management

|Shortcut|Action|
|---|---|
|`Cmd + A c`|New window|
|`Cmd + A ,`|Rename window|
|`Cmd + A n`|Next window|
|`Cmd + A p`|Previous window|
|`Cmd + A &`|Close current window|

---
## 📐 Pane Management

| Shortcut    | Action                         |
| ----------- | ------------------------------ |
| `Cmd + A    | `                              |
| `Cmd + A -` | Horizontal split               |
| `Cmd + A m` | Maximize/minimize current pane |

### 🔼 Resize Panes

|Shortcut|Direction|
|---|---|
|`Cmd + A j`|Down|
|`Cmd + A k`|Up|
|`Cmd + A h`|Left|
|`Cmd + A l`|Right|

---
## 📜 Copy Mode (Vi-style)

| Shortcut    | Action                 |
| ----------- | ---------------------- |
| `Cmd + A [` | Enter copy mode        |
| `v`         | Start visual selection |
| `y`         | Copy selection         |
| `Cmd + A ]` | Paste                  |

> Mouse support is enabled with:  
> `set -g mouse on`

---

### 🔑 Prefix Key

| Command                           | Description                      |
| --------------------------------- | -------------------------------- |
| `cat ~/.tmux.conf \| grep prefix` | Confirm prefix remapped to `C-a` |
| `set-option -g prefix C-a`        | Sets the prefix to `Cmd + A`     |
| `unbind C-b`                      | Unbinds default `Ctrl + B`       |
| `bind C-a send-prefix`            | Allows nested tmux prefixes      |

---
## 🔌 Plugins & Setup
> Managed with [TPM – Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

| Plugin               | Description                             |
| -------------------- | --------------------------------------- |
| `vim-tmux-navigator` | Move between tmux panes + Vim splits    |
| `tmux-themepack`     | Themes; you're using **Powerline Cyan** |
| `tmux-resurrect`     | Restore sessions after reboot           |
| `tmux-continuum`     | Auto-saves sessions every 15 minutes    |
|                      |                                         |


<br/>
<br/>
<br/>
<br/>

# **🧬 WezTerm Things**
> 🪄 **Note:** I do some cool magic where `Ctrl` = `Cmd` on macOS. So whenever you see `Ctrl`, just know it's doing double duty as your beloved `Cmd`.
---
### 🔑 **Leader Key**
- Your leader is Ctrl + Space  
    _(Used for triggering multi-key bindings like resizing, etc.)_

# ⚙️ Configuration Reload

| Shortcut         | Action                |
| ---------------- | --------------------- |
| Ctrl + Shift + R | Reload wezterm config |

### 🖱 Mouse

| Action           | Behavior                                         |
| ---------------- | ------------------------------------------------ |
| **Right Click**  | Paste (or copy if text is selected)              |
| **Triple Click** | Select semantic zone (e.g., full paragraph/line) |

