 <p align="center"> 
    <picture>
      <img src="../Docs/images/Devim_logo.png" height="180">
    </picture>
</p>

<div align="center">
  <img src="https://img.shields.io/github/last-commit/DevonGifford/DeVim?style=for-the-badge" alt="Last Commit">
  <img src="https://img.shields.io/badge/synced-yes-green?style=for-the-badge" alt="Synced">
  <img src="https://img.shields.io/badge/build-passing-brightgreen?style=for-the-badge" alt="Build">
  <img src="https://img.shields.io/badge/version-v1.0-blue?style=for-the-badge" alt="Version">
</div>

<div align="center">
  <img src="https://img.shields.io/badge/code%20quality-excellent-brightgreen?style=for-the-badge" alt="Code Quality">
  <img src="https://img.shields.io/github/stars/DevonGifford/DeVim?style=for-the-badge" alt="Stars">
</div>

<br/>
<br/>

## _**Who says you can't Vim and look good on Windows?**_


Hey, I’m Devon - and this is DeVim, my personal, curated dotfiles and tooling setup for Windows + WSL2. It’s built around a keyboard-driven workflow, utilizing the best of WSL and NeoVim to keep development fast and terminal-focused.  Feel free to explore, customize, or shamelessly steal. Suggestions welcome. ❤️

> [!WARNING]
> These dotfiles are always under active development. Things may change, move, or stomp on your existing config.
> <br /> Take what you want, but back up first — _getting mogged by fig files can lead to reckless copy-pasting. You’ve been warned._

<br />
<br />

## ⚙️ System Overview

Windows out of the box isn’t exactly dev-friendly. Thankfully, even Microsoft knew that — so they gave us [WSL2](https://learn.microsoft.com/en-us/windows/wsl/), which lets you run a real Linux environment inside Windows. No VM pain, no dual-boot drama.
That means your macOS/Linux-style dev workflow - _meaning; dotfiles, shell configs, package managers, SSH, Git and Docker etc._ - all works the same way and most importantly stays fast & snappy. Just use WSL.

#### 🪟 Native Windows Essentials

Because WSL Still Has a Landlord, it need's help. Not required, but strongly recommended - these apps fix the friction points and make the janky Windows OS feel slightly more usable.  

- **[PowerToys](https://github.com/microsoft/PowerToys)** - should've been built-in years ago. Window snapping and a Raycast-style launcher. Non-negotiable.
- **[Windows Terminal](https://github.com/microsoft/terminal)** - WSL, PowerShell, and CMD in one tabbed UI. You'll thank yourself during setup.
- **[PowerShell 7](https://github.com/PowerShell/PowerShell)** - stop using the 1995 version.

#### ✔ Prerequisites

On Windows, there’s honestly a lot, and I’m not going to walk through every click. At a high level: fresh Windows install ([LinusTechTips](https://youtu.be/MBCiMK4AmEI?si=C1Hr_azvgjPjfAf2)) → debloat ([win11debloat](https://github.com/raphire/win11debloat)) → PowerToys + Windows-Terminal → PowerShell7 → WSL2 + Ubuntu + WezTerm. From there, you’re mostly living in Linux and you can take over.  Also, install a [Nerd Font](https://www.nerdfonts.com/) on the Windows side so your terminal renders correctly.

_FYI — Don't bother setting up a dev environment in native windows (i.e PowerShell). You technically can get Neovim, SSH, Starship and replacement tools like oh_my_posh blah blah - but it's just not worth it, trust me. Sluggish, fragile and painful. Do everything through WSL and don't look back, I wish someone had told me that years ago._

> So yeah, it's a hybrid setup — because no matter how far you run... you're still on Windows. 🙃
> <br/> *WSL-Linux shell for real work, Windows shell when you have no choice.*

<br />
<br />

## 📝Developer Tools Collection

A curated list of tools I use daily to support a fast, keyboard-driven terminal-first development workflow on Windows machine. These fill in the gaps, improve the defaults, 
Dont forget the 'Native Windows Essentails' mentioned above.

#### General Tools:
- **[Obsidian](https://obsidian.md/)**: Markdown-based, local-first, Vim-friendly note-taking. Cross-platform so your vault follows you everywhere.
- **[LocalSend](https://localsend.org/)**: Cross-platform AirDrop alternative. Useful across Linux/Mac/Windows.
- **[KeePassXC](https://keepassxc.org/)**: Local password manager. No cloud, no subscription, no drama.
- **[Todoist](https://todoist.com/)**: A clean, cross-platform to-do app for personal tasks, dev stuff, and whatever chaos I’m pretending to control.

#### Terminal:
- **[WezTerm](https://wezfurlong.org/wezterm/index.html)**: GPU-accelerated, cross-platform, lua-configurable and powered by Rust - the one I actually use.
- **[Windows Terminal](https://github.com/microsoft/terminal)**: Still the best native terminal on Windows - my fallback for tasks beyond WSL's scope.

#### Shell & Prompt
- **[zsh](https://www.zsh.org/) + [Oh My Zsh](https://ohmyz.sh/)**: Fast, scriptable, and gets out of the way. Selective plugins make it feel modern. 
- **[Starship](https://starship.rs/)**: Fast, portable, and Rust-powered. One binary, one starship.toml, works across every shell I care about.  

#### Editors:
- **[Neovim](https://neovim.io/)**: My main job, I mean editor. Blazingly fast, keyboard-first, and fully configurable with [Lua](https://www.lua.org/).
- **[VSCode](https://code.visualstudio.com/)**: The fallback, fast to spin up, decent Vim support and reliable across platforms.

#### Terminal Multiplexing with tmux
- **[`tmux`](https://en.wikipedia.org/wiki/Tmux)**: A terminal multiplexer for splitting panes, running parallel processes, and keeping sessions alive - even after closing the terminal.
> *WezTerm’s pane support is tempting, but tmux has the ecosystem, the shortcuts, and years of muscle memory behind it.*

<br/>
<br/>

#### 🧰 Other CLI Tools
These tools are now part of the core experience (via Homebrew in WSL):
- **[`zoxide`](https://github.com/ajeetdsouza/zoxide)** – Modern `cd`. Learns your most used dirs, jump to them faster with fuzzy matches.  (Rust gang)  
- **[`eza`](https://github.com/eza-community/eza)** – Modern `ls`, the rewrite of deprecated exa with built-in color, icons, and better defaults.   (Rust gang)  
- **[`fzf`](https://github.com/junegunn/fzf)** – Fuzzy search for files, history, Git, you name it. Type less, find more it’ll guess what you meant.  (Go gang)
- **[`bat`](https://github.com/sharkdp/bat)** – Drop-in replacement for `cat` with syntax highlighting, line numbers, and paging support. Tokyo themed.
- **[`ripgrep`](https://github.com/BurntSushi/ripgrep)** – Blazing fast `grep` alternative. Used by modern editors. (Rust gang) 
- **[`fd`](https://github.com/sharkdp/fd)** – A simpler, faster alternative to `find`. Better syntax, better defaults, less pain.  
- **[`lazygit`](https://github.com/jesseduffield/lazygit)** – TUI Git client that simplifies staging, branching, rebasing, and reviewing commits.(Go gang) 
- **[`tldr`](https://tldr.sh/)** – Simplified, community-driven man pages, with real-world examples and no fluff.
- **[`nvm`](https://github.com/nvm-sh/nvm)** – Node version manager. Staple tool, cross-platform and reliable.
- **[`thefuck`](https://github.com/nvbn/thefuck)** – Messed up a command? It’ll suggest the right one. Surprisingly useful, endlessly satisfying. (Python gang)
- **[`GitHub Copilot CLI`](https://github.com/github/cli-copilot)** – AI for your terminal, generate commands, explain errors and pretend you did it yourself. 
- **[`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)** – Suggests commands from your history as you type.
- **[`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)** – Adds real-time syntax highlighting to your Zsh input. 

<br/>

#### 📁 What's Not In This Repo
This repo only tracks configs that differ from Omarchy's defaults. The following are installed and configured on the machine but intentionally not tracked here:
Windows still has its own pile of app state, GUI settings, tokens, caches, profiles, and “why is this locked by OneDrive?” nonsense. That stuff lives on the machine, not in git. If you’re copying this setup and something looks different, it’s probably one of these:

- WSL distro install/state — the distro itself is not tracked; this repo assumes you already have WSL2 + Ubuntu installed
- Windows Terminal settings — may be documented, but full local profile state is machine-specific
- PowerToys — useful, but configured through Windows and not core dotfiles
- PowerShell profile — separate from Linux shell config; only track it if you actually use it
- Browser profiles — cookies, sessions, extensions, history; absolutely not
- VS Code / Cursor Remote WSL state — extensions/settings may be documented, but full app state is not tracked
- `C:\Users\<you>\.ssh\` — Windows-side SSH keys stay private
- `/mnt/c/...` — Windows files mounted into WSL; do not build your Linux home inside there unless you enjoy pain
- `~/.ssh/`, `~/.gnupg/` — keys and trust state stay private
- `~/.docker/`, `~/.kube/` — local contexts, auth, and machine-specific config
- `~/.aws/`, `~/.config/gcloud/`, `~/.azure/` — cloud credentials and profiles
- `~/.npmrc`, `~/.yarnrc.yml` — package-manager auth/local settings

<br/>
<br/>

---
