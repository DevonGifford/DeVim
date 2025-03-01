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

Windows out of the box isn’t exactly dev-friendly. Thankfully, even Microsoft knew that — so they gave us [WSL2](https://learn.microsoft.com/en-us/windows/wsl/), which lets you run a full Linux distro inside Windows. No VM pain, no dual-boot drama. I use Ubuntu (default for WSL), and honestly, it just works. Big community, easy package management, good vibes. If you're new to Linux, it’s a solid starting point. Most of my dev workflow lives entirely in WSL now, with NeoVim.

#### Because WSL Still Has a Landlord

But let’s be real — it’s still Windows underneath. Some things just don’t play nice inside the WSL sandbox: disk partitioning, system-level tweaks, certain admin utilities. Some of these scars/configs are left over from the pre-WSL era, so yeah a few essentials still live on the native side:

-   **Windows Terminal**, with profiles for WSL and PowerShell.
-   **PowerShell7**, for scripting and admin wrangling.
-   **Chocolatey**, for managing core native apps.

> So yeah, it’s a hybrid setup — Because no matter how far you run... you're still on Windows. 🙃
> <br/> _Linux shell for real work, Windows shell when you have no choice._

<br />
<br />

## ✔ Prerequisites

Make sure you’ve got the following installed before diving in:

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

From the days of Notepad, Sublime, and cursed Xcode, the reigning stable GOAT [VSCode](https://code.visualstudio.com/) has been my go-to — fast to set up, Vim mode actually works, and it doesn’t fight you every step of the way. But after years of shipping code (and the rise of LazyVim), I fell into the [Neovim](https://neovim.io/) rabbit hole. No ragrats.

Neovim is lean, keyboard-driven, and fully customizable — everything’s in [Lua](https://www.lua.org/). My config is based on [LazyVim](https://github.com/LazyVim/LazyVim), which saves me from losing full weekends to plugin rabbit holes. That said, I still keep that thang on me (referring to VSCode, obviously).

And then there’s the new [Cursor](https://cursor.sh/) — something I’ve been playing with more and more. It’s basically VSCode with AI running through its veins. Think Copilot++, and having ChatGPT-style prompts _inside_ your editor is weirdly _a vibe_.

<br/>

#### Persistent Terminal Sessions with tmux

[`tmux`](https://en.wikipedia.org/wiki/Tmux) is a terminal multiplexer — think tabs and splits, but for your terminal.

-   Split your terminal into multiple panes (vertical, horizontal, whatever)
-   Run different commands side by side (`npm run dev` in one, Git in another)
-   Detach from a session and pick up where you left off — even after closing the terminal

Great for keeping dev servers, builds, and SSH sessions alive while you jump between tasks — no restarts, no lost progress, no rage.

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
-   [@JazzyGrim](https://github.com/JazzyGrim "Sindo")
-   [@devaslife](https://www.devas.life/)
-   [@tjdevries](https://github.com/tjdevries)
-   [@ThePrimeagen](https://github.com/theprimeagen)

---
