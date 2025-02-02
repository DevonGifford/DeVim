 <p align="center"> 
    <picture>
      <img src="../Docs/logo2.png" height="180">
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

Hey, I’m Devon — and this is DeVim, my personal, curated dotfiles and tooling setup for Windows + WSL2. It’s built around a Linux-first workflow, blending the best of WSL, PowerShell, and NeoVim to keep development fast and terminal-focused.

Feel free to explore, customize, or shamelessly steal. Suggestions welcome. ❤️

> [!WARNING]\
> This setup is under **active development**. Things may change frequently, and existing config files might get overwritten.  
> <br /> _Make sure to back up anything you want to keep._  

<br />
<br />

## ⚙️ System Overview

Windows out of the box isn’t exactly dev-friendly. Thankfully, even Microsoft knew that — so they gave us [WSL2](https://learn.microsoft.com/en-us/windows/wsl/), which lets you run a full Linux distro inside Windows. No VM pain, no dual-boot drama. Most of my dev workflow lives entirely in WSL now, with NeoVim.

#### Because WSL Still Has a Landlord

But let’s be real — it’s still Windows underneath. Some things just don’t play nice inside the WSL sandbox, like system-level tweaks, certain admin utilities. Some of these scars/configs are left over from my pre-WSL era, so yeah a few essentials still live on the native side:

-   **[Windows Terminal](https://github.com/microsoft/terminal)**: Profiles for WSL and PowerShell, tabbed UI, theming — the default terminal for modern Windows devs.
-   **[PowerShell 7](https://github.com/PowerShell/PowerShell)**: For scripting, automation, and native admin tasks.
-   **[Chocolatey](https://chocolatey.org/)**: Windows package manager for installing core CLI apps and tools.

> So yeah, it’s a hybrid setup — Because no matter how far you run... you're still on Windows. 🙃
> <br/> _Linux shell for real work, Windows shell when you have no choice._

<br />
<br />

## ✔ Prerequisites

Before you dive in, make sure you have these installed:


-   [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) – Windows Subsystem for Linux. Lets you pretend Windows isn’t running under your terminal.
-   [Ubuntu (via WSL)](https://ubuntu.com/wsl) – South African for “humanity toward others.” Fitting — it mostly works and stays out of the way.
-   [Node.js](https://nodejs.org/) - Recommended to have node version manager installed too.
-   [C compiler](https://clang.llvm.org/) - Check out `gcc`, `clang`, or [Zig](https://ziglang.org/) if you’re cool.
-   [Lua](https://www.lua.org/) - Just enough to tweak configs without crying.
-   [GitHub CLI](https://cli.github.com/) – Needed for Copilot CLI magic.
-   [PowerShell 7](https://github.com/PowerShell/PowerShell) - For the native Windows scripting stuff you can’t escape.
-   [Nerd Fonts](https://www.nerdfonts.com/) - Ensure Hacker Nerd and Fira Code Nerd Fonts are accessable.
-   [A healthy fear of GUIs](https://www.freecodecamp.org/news/command-line-for-beginners/) - Assumes you're comfortable in the terminal and can Vim your way out of trouble.

<br />
<br />

## 📝Developer Tools Collection

A curated list of tools that I use on a daily basis for my development workflow. Below are the main tools included:

#### General Tools:

Windows doesn’t make dev life easy — you’ve got to duct-tape your own workflow together.

-   **[Flow Launcher](https://github.com/Flow-Launcher/Flow.Launcher)**: Basically the poor mans Raycast/Spotlight for Windows. Launch apps, search files, run scripts etc.
-   **[PowerToys](https://github.com/microsoft/PowerToys)**: Useful Windows tools (snapping, color picker, etc.) that should’ve been built-in years ago.
-   **[Obsidian](https://github.com/obsidianmd)**: Markdown-based, local-first, Vim-friendly, cross-platform note-taking app, Excalidraw plugin is cool too.
-   **[Todoist](https://todoist.com/)**: A clean, cross-platform to-do app for personal tasks, dev stuff, and whatever chaos I’m pretending to control.

<br/>

#### Terminal:
- **[WezTerm](https://wezfurlong.org/wezterm/index.html)**: GPU-accelerated, cross-platform, and Lua-configurable — the one I actually use. Works across Linux, macOS, and WSL, and powered by Rust so I can pretend I’m fast too.
- **[Windows Terminal](https://github.com/microsoft/terminal)**: Still the best native Windows terminal — my fallback when WSL isn’t enough.  Just don't forget to grab [PowerShell7](https://github.com/PowerShell/PowerShell), unless you enjoy living in the 90s.
> *For fonts, I use [Nerd Fonts](https://www.nerdfonts.com/), usually use Hacker Nerd Font, but sometimes I switch it up just to feel something.*
<br/>

#### Shell
- **[zsh](https://www.zsh.org/)** ([with Oh My Zsh](https://ohmyz.sh/)): Fast, scriptable, and gets out of the way. Selective plugins make it feel modern. 
- **[PowerShell 7](https://github.com/PowerShell/PowerShell)**: Necessary evil on Windows. It’s not great, alias everything or suffer.
> *Don’t forget to install Zsh plugins — autosuggestions and syntax highlighting go a long way.*
<br/>

#### Prompt
- **[Starship](https://starship.rs/)**: Fast, portable, and Rust-powered. One binary, one starship.toml, and it just works across every shell I care about.  
> *Custom minimal styling — Tokyo Night meets power10k inspired, but nothing too loud.*
<br/>

#### Editors:
Over the years, I’ve used everything from Notepad and Sublime to the cursed Xcode.
- **[VSCode](https://code.visualstudio.com/)**: The GOAT fallback — fast to spin up, decent Vim support, and reliable across platforms.
- **[Neovim](https://neovim.io/)**: My main job, I mean editor — blazingly fast, keyboard-first, and fully configurable with [Lua](https://www.lua.org/).
- **[Cursor](https://cursor.sh/)**: The experimental one — AI-heavy, Copilot-native, and weirdly useful when vibe matters more than precision.
> *Use what works, configure what doesn't, and pretend the defaults were fine all along.*
<br/>

#### Terminal Multiplexing with tmux
**[`tmux`](https://en.wikipedia.org/wiki/Tmux)**: A terminal multiplexer for splitting panes, running parallel processes, and keeping sessions alive — even after closing the terminal.
> *WezTerm’s pane support is tempting, but tmux has the ecosystem, the shortcuts, and years of muscle memory behind it.*

<br/>
<br/>

#### 🧰 Other CLI Tools
These tools are now part of the core experience (via Homebrew in WSL):
- **[`zoxide`](https://github.com/ajeetdsouza/zoxide)** – Like `cd`, but actually useful. Tracks the directories you visit most and lets you jump to them with fuzzy-matched shortcuts. Written in Rust.  
- **[`eza`](https://github.com/eza-community/eza)** – Modern replacement for `ls`, with built-in color, icons, and better defaults. Easier on the eyes and much more useful out of the box.  
- **[`bat`](https://github.com/sharkdp/bat)** – Drop-in replacement for `cat` with syntax highlighting, line numbers, and paging support. Makes reading code and logs way easier.  
- **[`fzf`](https://github.com/junegunn/fzf)** – Fuzzy finder for your terminal — search files, command history, Git commits, whatever. Type a few characters and it’ll guess what you meant.  
- **[`ripgrep`](https://github.com/BurntSushi/ripgrep)** – Fast recursive text search tool. Used under the hood by many modern editors and CLI tools — much faster and more intuitive than `grep`.  
- **[`fd`](https://github.com/sharkdp/fd)** – A simpler, faster alternative to `find`. Better syntax, better defaults, less pain.  
- **[`lazygit`](https://github.com/jesseduffield/lazygit)** – TUI Git client that simplifies staging, branching, rebasing, and reviewing commits. Great for quick Git workflows without leaving the terminal.  
- **[`tldr`](https://tldr.sh/)** – Simplified, community-driven man pages. Shows real-world examples and just enough context to get things done.  
- **[`thefuck`](https://github.com/nvbn/thefuck)** – Messed up a terminal command? Just type `fuck` and it’ll suggest the right one. Surprisingly useful, endlessly satisfying.  
- **[`GitHub Copilot CLI`](https://github.com/github/cli-copilot)** – Copilot for your terminal. Generate commands, explain errors, and pretend you typed it all yourself. Requires `gh auth login`.  
- **[`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)** – Suggests commands from your history as you type. Makes repetition fast and muscle memory even faster.  
- **[`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)** – Adds real-time syntax highlighting to your Zsh input. Great for spotting mistakes before they happen.  
- **[`nvm`](https://github.com/nvm-sh/nvm)** – Node version manager. Cross-platform, reliable, and keeps global installs from leaking everywhere. Works great in WSL and macOS.

<br/>
<br/>

---
