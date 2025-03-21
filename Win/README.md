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

Windows out of the box isn’t exactly dev-friendly. Thankfully, even Microsoft knew that — so they gave us [WSL2](https://learn.microsoft.com/en-us/windows/wsl/), which lets you run a full Linux distro inside Windows. No VM pain, no dual-boot drama. I use Ubuntu (default for WSL), and honestly, it just works. Big community, easy package management, good vibes. If you're new to Linux, it’s a solid starting point. Most of my dev workflow lives entirely in WSL now, with NeoVim.

#### Because WSL Still Has a Landlord

But let’s be real — it’s still Windows underneath. Some things just don’t play nice inside the WSL sandbox: disk partitioning, system-level tweaks, certain admin utilities. Some of these scars/configs are left over from the pre-WSL era, so yeah a few essentials still live on the native side:

-   **[Windows Terminal](https://github.com/microsoft/terminal)**: Profiles for WSL and PowerShell, tabbed UI, theming — the default terminal for modern Windows devs.
-   **[PowerShell 7](https://github.com/PowerShell/PowerShell)**: For scripting, automation, and native admin tasks.
-   **[Chocolatey](https://chocolatey.org/)**: Windows package manager for installing core CLI apps and tools.

> So yeah, it’s a hybrid setup — Because no matter how far you run... you're still on Windows. 🙃
> <br/> _Linux shell for real work, Windows shell when you have no choice._

<br />
<br />

## ✔ Prerequisites

Before you dive in, make sure you have these installed:


-   [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) – Ideally Ubuntu. Your Linux playground inside Windows.
-   [Node.js](https://nodejs.org/) - recommended to have node version manager installed too.
-   [C compiler](https://clang.llvm.org/) - check out `gcc`, `clang`, or [Zig](https://ziglang.org/) if you’re feeling spicy.
-   [Lua](https://www.lua.org/) - just enough to tweak configs without crying.
-   [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) - with Ubuntu (or your Linux flavor of choice).
-   [GitHub CLI](https://cli.github.com/) – needed for Copilot CLI magic.
-   [PowerShell 7](https://github.com/PowerShell/PowerShell) - for the native Windows scripting stuff you can’t escape.
-   [Nerd Fonts](https://www.nerdfonts.com/) - ensure Hacker Nerd and Fira Code Nerd Fonts are accessable.
-   [A healthy fear of GUIs](https://www.freecodecamp.org/news/command-line-for-beginners/) - this setup assumes you're comfortable in the terminal and can Vim your way out of trouble.

<br />
<br />

## 📝Developer Tools Collection

A curated list of tools that I use on a daily basis for my development workflow. Below are the main tools included:

#### General Tools:

Windows doesn’t make dev life easy — you’ve got to duct-tape your own workflow together. These are the tools I use to fill in the gaps, smooth out the rough edges, and keep me from rage-quitting every time I switch tasks.

-   **[Flow Launcher](https://github.com/Flow-Launcher/Flow.Launcher)**: Basically the poor mans Raycast/Spotlight for Windows. Launch apps, search files, run scripts, all from a keystroke. Way better than aimlessly clicking around the Start Menu.
-   **[PowerToys](https://github.com/microsoft/PowerToys)**: Microsoft’s grab bag of actually-useful utilities. Window snapping, color picking, and a bunch of other things that should be baked into the OS but aren’t.
-   **[Obsidian](https://github.com/obsidianmd)**: My second brain. Markdown-based, local-first, Vim-friendly, cross-platform note-taking app. Perfect for documenting setups, writing brain dumps, or avoiding actual work.
-   **[Todoist](https://todoist.com/)**: A clean, cross-platform to-do app I use to keep track of personal tasks, dev stuff, and whatever chaos I’m pretending to control.

<br/>

#### Terminal:

GPU-accelerated terminals are all the rage, and if you’re like me—bouncing between Linux, macOS, and Windows—[WezTerm](https://wezfurlong.org/wezterm/index.html) is a pretty solid cross-platform option. After trying the usual suspects (Alacritty, Kitty, Warp), I landed on WezTerm mainly because it’s consistent, cross-platform, and Lua-configurable. Plus, it’s written in Rust, so you can pretend you're a performance snob while telling yourself it’s about productivity.

That said and as already mentioned, not everything plays nice with WSL, some admin tasks still need native Windows and Powershell. Thus [Windows Terminal](https://github.com/microsoft/terminal) is non-negotiable. I haven’t found a better emulator on Windows: tabs, profiles, custom themes — it just works. Just don't forget to get PowerShell7 and get stuck in the 90s. - [PowerShell7](https://github.com/PowerShell/PowerShell):

For fonts, I use [Nerd Fonts](https://www.nerdfonts.com/), usually use Hacker Nerd Font, but sometimes I switch it up just to feel something.

<br/>

#### Shell

This repo runs on [`Oh My Zsh`](https://ohmyz.sh/), because I’m not a caveman. Over the years, I’ve bounced between `bash`, `fish`, `PowerShell`, and even `cmd.exe` (yikes) — mostly just trying to mimic what `zsh` does natively on Linux/macOS. So inside WSL, it’s my default shell (though I still keep a `bashrc` around, just in case). `Oh My Zsh` manages plugins like autosuggestions, syntax highlighting, Git integration — all the stuff I pretend I couldn’t live without. Most of the chaos lives in `.zshrc`.

On native Windows, I use [PowerShell 7](https://github.com/PowerShell/PowerShell). I used to pair it with [`Oh My Posh`](https://ohmyposh.dev/) to fake that `Oh My Zsh` feel, but I've since moved over to [`Starship`](https://starship.rs) — it's simpler, cleaner, and doesn’t care whether you're on Mac, Linux, or trapped on native Windows.

<br/>

#### Prompt

I used to use [`Powerlevel10k`](https://github.com/romkatv/powerlevel10k) — fast and fully customizable — but I’m switching to [`Starship`](https://starship.rs) for something more minimal, cross-shell, and that doesn’t require gluing together five config files.

The config lives at `~/.config/starship.toml`, and tweaking it is surprisingly painless. On WSL and macOS, I’m already all-in. On Windows, I’m slowly phasing out `Powerlevel10k` and [`Oh My Posh`](https://ohmyposh.dev/) in favor of full-time Starship.

<br/>

#### Editors:

Over the years, I’ve used everything from Notepad and Sublime to Xcode and VSCode. These days, [VSCode](https://code.visualstudio.com/) remains a reliable fallback — quick to set up, solid Vim support, and flexible enough for most workflows.

That said, I’ve fully transitioned to [Neovim](https://neovim.io/) as my primary editor. It’s fast, keyboard-focused, and fully configurable in [Lua](https://www.lua.org/). My setup is built on [LazyVim](https://github.com/LazyVim/LazyVim), which handles the plugin ecosystem without getting in the way.

More recently, I’ve been experimenting with [Cursor](https://cursor.sh/), an AI-enhanced editor built on top of VSCode. Integrated Copilot and inline prompt support make it surprisingly productive — especially for quick prototyping or exploring unfamiliar code.

<br/>

#### Persistent Terminal Sessions with tmux

[`tmux`](https://en.wikipedia.org/wiki/Tmux) is a terminal multiplexer that lets you manage multiple terminal sessions within a single window.

- Split your terminal into multiple panes (vertically or horizontally)  
- Run parallel processes side by side (e.g., server logs, Git, build tools)  
- Detach and resume sessions without losing progress — even after closing the terminal  

It's especially useful for keeping long-running processes or remote sessions active across workflows, without restarting

<br/>
<br/>

#### 🧰 Other CLI Tools

These tools are now part of the core experience (via Homebrew in WSL):

-   **[`zoxide`](https://github.com/ajeetdsouza/zoxide)** is like `cd`, but actually useful. It tracks the directories you visit most often, and then lets you jump to them with fuzzy-matched shortcuts. It’s written in Rust (so you can pretend it’s fast and secure™) and basically replaces the part of your brain that remembers folder paths.
-   **[eza](https://github.com/eza-community/eza)** A modern replacement for `ls` with colors, icons, tree views, and actual readability. Once you see your files in `eza`, going back to `ls` feels like reading source code on Notepad.
-   **[bat](https://github.com/sharkdp/bat)** It’s `cat`, but with syntax highlighting, line numbers, and a bit of flair. If `cat` is a flip phone, `bat` is an iPhone with dark mode enabled.
-   **[fzf](https://github.com/junegunn/fzf)** Fuzzy finder for your terminal — search files, command history, Git commits, whatever. Type a few characters and it’ll guess what you meant. Like a mind reader, but for file paths.
-   **[ripgrep](https://github.com/BurntSushi/ripgrep)** A super fast text search tool that makes `grep` feel like it’s running on dial-up. Used by tools like Telescope in Neovim, it’s your go-to for searching across codebases in milliseconds.
-   **[thefuck](https://github.com/nvbn/thefuck)** Messed up a terminal command? Just type `fuck` and it’ll suggest the right one. Hit enter, and boom — fixed. Surprisingly useful, endlessly satisfying.
-   **[GitHub Copilot CLI](https://github.com/github/cli-copilot)** Copilot, but for your terminal. Generate commands, explain errors, and pretend you're doing twice the work with half the effort. Requires setup via `gh auth login`, but totally worth it.

<br/>
<br/>


---
