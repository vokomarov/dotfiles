# My personal dotfiles

My personal dotfiles. Originally forked from [@freekmurze](https://githum.com/freekmurze) (https://github.com/freekmurze/dotfiles).

It contains the installation of some basic tools, some handy aliases and functions.

Software:
- iTerm2
- ZSH
- Oh-My-Zsh
- PHPStorm
- GoLand

You can install them by cloning the repository as `.dotfiles` in your home directory and running the bootstrap script.

```
brew install bash-completion
git clone git@github.com:vokomarov/dotfiles.git .dotfiles
cd .dotfiles
./bootstrap
```

The bootstrap script can be run by cd-ing into the `.dotfiles` directory and performing this command:

```bash
./bootstrap
```

## Claude Code Skills

Skills are managed via `config/claude/skills-manifest.json` and the `claude-skill` script. All skills are tracked with their upstream GitHub sources.

### Update all skills

```bash
claude-skill
```

### Update specific skills

```bash
claude-skill vue-best-practices typefully
```

### List all skills and their sources

```bash
claude-skill --list
```

### Install a new skill

The script clones the skill, detects its name from `SKILL.md`, copies it into the skills directory, and adds an entry to the manifest automatically.

```bash
# Skill is the whole repo
claude-skill install https://github.com/user/my-skill

# Skill lives in a subdirectory of a larger repo
claude-skill install https://github.com/org/skills-repo --subdir skills/my-skill

# Pin to a specific branch, tag, or commit
claude-skill install https://github.com/org/repo --subdir skills/my-skill --ref v2.0.0

# Override the local name (when upstream name differs)
claude-skill install https://github.com/org/repo --subdir path/to/skill --name my-local-name
```

### Check for newer upstream versions

Shows only skills that have updates available. Skills without a recorded SHA (never updated via the script) are listed separately. Uses `git ls-remote` — no cloning required.

```bash
claude-skill outdated
```

### Sync manually added skills

If you copied a skill directory manually, run `sync` to register any untracked directories into the manifest. They will be added with `status: unknown` — edit the manifest to set their git source.

```bash
claude-skill sync
```

### Show help

```bash
claude-skill help
```

Skills are also updated automatically when running the main `./update` script.

## Author

Author of original setup [@freekmurze](https://githum.com/freekmurze) (https://github.com/freekmurze/dotfiles). Thanks for this awesome setup. 
