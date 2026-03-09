# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

Personal dotfiles for macOS with ZSH/Oh-My-Zsh. Key directories:

- `bootstrap` / `installscript` — full system setup scripts (run once on a new machine)
- `update` — updates dotfiles, Homebrew packages, npm/Composer globals, and Claude skills
- `config/Brewfile` — all Homebrew packages and casks
- `config/claude/` — Claude Code configuration, symlinked to `~/.claude/` on install
  - `CLAUDE.md` — global Claude instructions (symlinked to `~/.claude/CLAUDE.md`)
  - `settings.json` — Claude Code permissions and settings
  - `skills/` — Claude skill directories (managed via `update-skills` script)
  - `skills-manifest.json` — tracks each skill's git source, ref, and installed SHA
  - `update-skills` — PHP CLI script for managing skills (aliased as `claude-skill`)
  - `agents/` — custom Claude agent definitions
- `shell/` — ZSH config files (`.zshrc`, `.aliases`, `.functions`, `.exports`)
- `misc/` — IDE settings, fonts, themes, and other static assets
- `macos/set-defaults.sh` — macOS system preference defaults
- `bin/` — scripts added to `$PATH` via `~/.dotfiles/bin`

## Claude Skills Management

The `claude-skill` alias runs `php ~/.dotfiles/config/claude/update-skills`.

```bash
claude-skill                    # update all tracked skills
claude-skill vue-best-practices # update specific skill(s)
claude-skill --list             # list all skills and sources
claude-skill outdated           # check for newer upstream versions
claude-skill install <git-url> [--subdir <path>] [--ref <ref>] [--name <name>]
claude-skill sync               # register manually added skill dirs
```

Skills are also updated automatically by `./update`.

## Installation Flow

1. `./bootstrap` → sources `installscript`
2. `installscript` installs Oh-My-Zsh, Homebrew packages, symlinks dotfiles, optionally runs `install-claude-code`
3. `install-claude-code` installs the Claude CLI and symlinks `config/claude/` → `~/.claude/`

## Dotfiles Customization

Local overrides go in `~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}` — these are sourced automatically and never committed to this repo.
