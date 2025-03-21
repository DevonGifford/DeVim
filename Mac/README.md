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

## _**A minimal Mac setup for full-stack development.**_

Hi, I’m Devon — and this is DeVim, my personal, curated dotfiles setup for macOS. It’s the toolkit I use daily for full-stack development, optimized around the terminal and powered by NeoVim.

Feel free to explore, customize, or shamelessly steal. Suggestions welcome. ❤️

> [!WARNING]\
> This setup is under **active development**. Things may change frequently, and existing config files might get overwritten.  
> <br /> _Make sure to back up anything you want to keep._  

<br />
<br />

## ⚙️ System Overview

macOS is a solid base for dev work — Unix roots, slick UI, and fewer headaches than most Linux setups. But it’s far from perfect. The stock terminal? Meh. Window management? Nonexistent. And the productivity layer is barely there. This setup fills in the blanks with tools that actually keep up. (without going fully linux)


#### Because macOS Still Needs a Bit of Help

Under the hood, it’s powerful — but you’ll need some upgrades to make it sing. These tools fix the friction points: smarter multitasking, better terminal, faster navigation, and less time wasted

- **[Raycast](https://www.raycast.com/)**: Like Spotlight, but actually good. App launcher, script runner, and productivity Swiss Army knife.
- **[Rectangle](https://rectangleapp.com/)**: Snap windows like it’s Windows. One of the first things I install on any Mac.
- **[AltTab](https://alt-tab-macos.netlify.app/)**: Cmd+Tab the way it was meant to be — with full previews and sanity restored.

> macOS does 80% of the job with style. This setup’s for the last 20% that actually matters.
> <br /> _It’s clean, it’s quiet, it mostly Just Works™ _ 🙌

<br />
<br />

## ✔ Prerequisites

Before diving in, make sure you’ve got these installed — or at least know what they’re for:

- **[Homebrew](https://brew.sh/)** – The package manager. You’ll use it for almost everything.
- **[Node.js](https://nodejs.org/)** – `nvm` recommended. Don't fight the versions manually.
- **[C compiler](https://clang.llvm.org/)** – Comes bundled with Xcode CLI tools.
- **[Lua](https://www.lua.org/)** – Needed for Neovim config, but not as scary as it sounds.
- **[GitHub CLI](https://cli.github.com/)** – Makes GitHub feel local. Essential for Copilot CLI too.
- **[Nerd Fonts](https://www.nerdfonts.com/)** – Hack Nerd and Fira Code Nerd are both great choices.
- **[A healthy fear of GUIs](https://www.freecodecamp.org/news/command-line-for-beginners/)** – this setup assumes you're comfortable in the terminal and can Vim your way out of trouble.

<br />
<br />

## 📝Developer Tools Collection

A curated list of tools I use daily to support a fast, keyboard-driven development workflow on macOS. These fill in the gaps, improve the defaults, and make terminal-first dev life smoother.

#### General Tools:

macOS is a solid base for development, but there are still areas where the default experience falls short. These tools improve window management, productivity, and app navigation:

-   **[Raycast](https://www.raycast.com/)**: The macOS launcher Apple wishes it built. Run scripts, manage extensions, control your system — all from your keyboard.
-   **[Obsidian](https://github.com/obsidianmd)**: My second brain. Markdown-based, local-first, Vim-friendly, cross-platform note-taking app. Perfect for documenting setups, writing brain dumps, or avoiding actual work.
-   **[Todoist](https://todoist.com/)**: A clean, cross-platform to-do app I use to keep track of personal tasks, dev stuff, and whatever chaos I’m pretending to control.

<br/>

#### Terminal:

I bounce between [WezTerm](https://wezfurlong.org/wezterm/index.html) and [iTerm2](https://iterm2.com/) — both are GPU-accelerated, highly configurable, and better than Apple's default terminal in every possible way. WezTerm wins on cross-platform consistency and Lua config. iTerm2 wins on polish and being mac-native.

For fonts, [Nerd Fonts](https://www.nerdfonts.com/) are a must. I'm partial to Hack Nerd and JetBrains Mono — aesthetic and readable.

<br/>

#### Shell

Zsh is the default on macOS, and I lean into it with [`Oh My Zsh`](https://ohmyz.sh/). Plugins, themes, autosuggestions, Git helpers — it’s all here. My config is in `.zshrc`.

<br/>

#### Prompt

I'm currently using [`Powerlevel10k`](https://github.com/romkatv/powerlevel10k) — fast, flexible, and highly customizable. That said, I’m gradually moving to [`Starship`](https://starship.rs) for a cleaner, cross-shell experience that doesn’t require juggling multiple config files.

<br/>

#### Editors

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

These tools are now part of the core experience via Homebrew:

-   **[`zoxide`](https://github.com/ajeetdsouza/zoxide)** is like `cd`, but actually useful. It tracks the directories you visit most often, and then lets you jump to them with fuzzy-matched shortcuts. It’s written in Rust (so you can pretend it’s fast and secure™) and basically replaces the part of your brain that remembers folder paths.
-   **[eza](https://github.com/eza-community/eza)** A modern replacement for `ls` with colors, icons, tree views, and actual readability. Once you see your files in `eza`, going back to `ls` feels like reading source code on Notepad.
-   **[bat](https://github.com/sharkdp/bat)** It’s `cat`, but with syntax highlighting, line numbers, and a bit of flair. If `cat` is a flip phone, `bat` is an iPhone with dark mode enabled.
-   **[fzf](https://github.com/junegunn/fzf)** Fuzzy finder for your terminal — search files, command history, Git commits, whatever. Type a few characters and it’ll guess what you meant. Like a mind reader, but for file paths.
-   **[ripgrep](https://github.com/BurntSushi/ripgrep)** A super fast text search tool that makes `grep` feel like it’s running on dial-up. Used by tools like Telescope in Neovim, it’s your go-to for searching across codebases in milliseconds.
-   **[thefuck](https://github.com/nvbn/thefuck)** Messed up a terminal command? Just type `fuck` and it’ll suggest the right one. Hit enter, and boom — fixed. Surprisingly useful, endlessly satisfying.
-   **[GitHub Copilot CLI](https://github.com/github/cli-copilot)** Copilot, but for your terminal. Generate commands, explain errors, and pretend you're doing twice the work with half the effort. Requires setup via `gh auth login`, but totally worth it.

<br/>

---
