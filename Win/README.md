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

> [!WARNING]\
> Under _**active development**_, expect changes. Existing configuration files will be overwritten.
> <br/> _Please make a backup of any files you wish to keep before proceeding._

<br/>

## _**Who says you can't Vim and look good on Windows?**_

Hi my name is Devon and this is DeVim, my personal curated collection of Windows + WSL tools I use for everyday full-stack development. This collection integrates NeoVim seamlessly into Windows via WSL2, consolidating scattered config files into one convenient location.

Feel free to explore and customize these tools to enhance your development experience! Your suggestions for improvements are always welcome! ❤

> ⚠️ **The bad news:**  
> This repo doesn’t come with an installer, wizard, or training montage.  
> It also won’t teach you Vim or NeoVim from scratch.

<br/>

> ✅ **The good news:**  
> If you know your way around a terminal, setup is chill.  
> I’ve also dropped a bunch of learning resources below to help you hit the ground running.See below

<br />
<br />

## ⚙️ System Overview

Windows out of the box isn’t exactly dev-friendly. Thankfully, even Microsoft knew that — so they gave us [WSL2](https://learn.microsoft.com/en-us/windows/wsl/), which lets you run a full Linux distro inside Windows. No VM pain, no dual-boot drama.

I use Ubuntu (default for WSL), and honestly, it just works. Big community, easy package management, good vibes. If you're new to Linux, it’s a solid starting point. Most of my dev workflow lives entirely in WSL now:

-   NeoVim (specifically LazyVim) is installed and configured inside WSL.
-   All CLI tools, dotfiles, and environment tweaks assume a Linux shell.
-   WSL is the default for editing, version control, terminal work — basically everything I touch during the day.

#### Because WSL Still Has a Landlord

Now, let’s talk about the _inevitable duality_ — the weird little dance between WSL and native Windows. WSL runs the show for dev work, but some things still need the landlord’s permission.
Not everything plays nice from inside the sandbox — stuff like disk partitioning, system tweaks, or a handful of admin utilities still require Windows itself. Here’s what still lives on the Windows side:

-   **Windows Terminal**, with profiles for WSL and PowerShell.
-   **PowerShell7**, for scripting and admin wrangling.
-   **Chocolatey**, for managing core native apps.
-   **VS Code**, the stable goat, got to have an instance running.

> So yeah, it’s a hybrid setup — Because no matter how far you run... you're still on Windows. 🙃
> <br/> > _Linux shell for real work, Windows shell when you have no choice._

<br />
<br />

## ✔ Prerequisites

Make sure you’ve got the following installed before diving in:

-   [Node.js](https://nodejs.org/)
-   [C compiler](https://clang.llvm.org/) (`gcc`, `clang`, or [Zig](https://ziglang.org/) if you’re feeling fancy)
-   [Git](https://git-scm.com/)
-   [Lua](https://www.lua.org/) basics (enough to read/tweak config)
-   [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) with a Linux distro (Ubuntu recommended)
-   [Homebrew for Linux](https://docs.brew.sh/Homebrew-on-Linux) installed inside WSL
-   [GitHub CLI (`gh`)](https://cli.github.com/) for Copilot CLI
-   [PowerShell 7](https://github.com/PowerShell/PowerShell) for native Windows scripting
-   [Windows Terminal](https://aka.ms/terminal) for managing WSL/PowerShell sessions
-   [Nerd Fonts](https://www.nerdfonts.com/) installed and selected in your terminal (I use Caskaydia Cove Mono)
-   [Vim](https://vim.rtorr.com/) & [CLI](https://www.stationx.net/windows-command-line-cheat-sheet/) chops — this setup assumes you're not scared of the terminal

<br />
<br />

## 📝Developer Tools Collection

A curated list of tools that I use on a daily basis for my development workflow. Below are the main tools included:

#### General Tools:

Let’s be honest: Windows doesn’t exactly roll out the red carpet for devs. You’ve got to duct-tape your own toolbox together just to get a halfway decent experience. These are the “make Windows suck less” tools that I rely on regularly — the kind of stuff that fills in the gaps and smooths out the daily pain of context switching between writing code, navigating files, and not rage-quitting productivity tools.

-   **[Flow Launcher](https://github.com/Flow-Launcher/Flow.Launcher)**: Basically the poor mans Raycast/Spotlight for Windows. Launch apps, search files, run scripts, all from a keystroke. Way better than aimlessly clicking around the Start Menu.
-   **[PowerToys](https://github.com/microsoft/PowerToys)**: Microsoft’s grab bag of actually-useful utilities. Window snapping, color picking, bulk renaming, and a bunch of other things that should be baked into the OS but aren’t. Every new feature is like, “Oh cool, this should’ve existed 10 years ago.”
-   **[Obsidian](https://github.com/obsidianmd)**: My second brain. Markdown-based, local-first, Vim-friendly note-taking app. Perfect for documenting setups, writing brain dumps, or avoiding actual work.
-   **[Todoist](https://todoist.com/)**: A clean, cross-platform to-do app I use to keep track of personal tasks, dev stuff, and whatever chaos I’m pretending to control.

<br/>

#### Terminal:

GPU-accelerated terminals are all the rage, and if you’re like me—bouncing between Linux, macOS, and Windows—[WezTerm](https://wezfurlong.org/wezterm/index.html) is a pretty solid cross-platform option. After trying the usual suspects (Alacritty, Kitty, Warp), I landed on WezTerm mainly because it’s consistent, cross-platform, and Lua-configurable. Plus, it’s written in Rust, so you can pretend you're a performance snob while telling yourself it’s about productivity.

That said, not everything plays nice with WSL — things like partitioning, system-level scripts, and some admin tasks still need native Windows. So yeah, the Windows stack isn’t dead yet. And for that, [Windows Terminal](https://github.com/microsoft/terminal) is non-negotiable. I haven’t found a better emulator on Windows: tabs, profiles, custom themes — it just works. Just don't forget to get PowerShell7 and get stuck in the 90s. - [PowerShell7](https://github.com/PowerShell/PowerShell):

For fonts, I use [Nerd Fonts](https://www.nerdfonts.com/), usually Caskaydia Cove Mono — sometimes I switch just to feel something.

<br/>

#### Shell

This repo runs on `Oh My Zsh`, because I’m not a caveman. Over the years I’ve bounced between `bash`, `fish`, `PowerShell`, and even `cmd.exe` (yikes), but `zsh` consistently hits the sweet spot: flexible, powerful, and not actively hostile.

Inside WSL, I use `zsh` as my primary shell (though I still keep a `bashrc` around, just in case). `Oh My Zsh` acts as the plugin manager, handling autosuggestions, syntax highlighting, Git integration, and all the other things I claim I can’t live without. Most of the chaos lives in `.zshrc`.

On native Windows, I use PowerShell 7. I used to pair it with `Oh My Posh` to fake that `Oh My Zsh` feel, but I've since moved over to `Starship` — it's simpler, cleaner, and just works.

<br/>

#### Prompt

The prompt is the flashy bit that shows your path, Git branch, Node version, and whether you’re in a good mood. It’s the UI on top of your shell’s logic.

I used to be all-in on `Powerlevel10k` for `zsh` — it’s snappy, heavily customizable, and honestly looks great. But lately, I’ve been migrating to `Starship`: it’s minimal, works across any shell (`zsh`, `bash`, `PowerShell`, whatever), and doesn’t require gluing together five config files just to change an icon.

Starship config lives in `~/.config/starship.toml`, and it’s surprisingly pleasant to work with. On WSL and macOS, I’m already using it full-time. On Windows, I’m weaning off `Powerlevel10k`/`Oh My Posh` and going full `Starship` soon.

<br/>

#### Editors:

From the days of Notepad, Sublime, and cursed Xcode, the reigning stable GOAT [VSCode](https://code.visualstudio.com/) has been my go-to — it’s fast to set up, actually makes Vim mode usable, and doesn’t fight you every step of the way. But after years of shipping code and the rise of LazyVim, I fell into the deep [Neovim](https://neovim.io/) rabbit hole. No ragrats.

Neovim is lean, keyboard-driven, and completely customizable — everything is written in [Lua](https://www.lua.org/), which feels like JavaScript’s smarter, quieter cousin. My config’s based on [LazyVim](https://github.com/LazyVim/LazyVim), which saves me from spending _too_ many hours tuning plugins when I should be doing, you know, actual work. That said, I always keep that thang on me (referring to VSCode, obviously).

And then there’s [Cursor](https://cursor.sh/) — something I’ve been playing with more and more. It’s basically VSCode with AI running through its veins. Think Copilot++, and having ChatGPT-style prompts _inside_ your editor is weirdly _a vibe_.

**TL;DR:**

-   `Neovim + LazyVim` for day-to-day solo work (inside WSL)
-   `VSCode` for pairing or "just get it done" sessions
-   `Cursor` AI Jesus take the wheel.

<br/>

#### Persistent Terminal Sessions with tmux

Think of [`tmux`](https://en.wikipedia.org/wiki/Tmux) as tabs and split views for your terminal — but on steroids. It's a **terminal multiplexer**, which basically means:

-   You can split your terminal into multiple panes (vertically, horizontally — go wild)
-   Run different commands in each pane (like `npm run dev` in one, Git in another)
-   Detach from a session and come back later — and everything is still running

It’s great when you’re deep into a dev workflow and don’t want to kill a running process just to do something else. I use it to keep long-running tasks (dev servers, builds, SSH sessions, etc.) open in one pane, while jumping into commits, logs, or file exploration in another.
If your terminal has ever felt cramped or chaotic — tmux is your new best friend.

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

## 🙌 Special Thanks

A huge thank you to the following individuals for their support:

-   [@jayson-lennon](https://github.com/jayson-lennon)
-   [@scottmckendry](https://github.com/scottmckendry)
-   [@JazzyGrim](https://github.com/JazzyGrim) (Sindo)
-   [@devaslife](https://www.devas.life/)
-   [@tjdevries](https://github.com/tjdevries)
-   [@ThePrimeagen](https://github.com/theprimeagen)

---
