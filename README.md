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

## Claude Code skills

Skills are managed via `config/claude/skills-manifest.json` and the `config/claude/update-skills` script. All skills are tracked with their upstream GitHub sources.

### Update all skills

```bash
python3 ~/.dotfiles/config/claude/update-skills
```

### Update specific skills

```bash
python3 ~/.dotfiles/config/claude/update-skills vue-best-practices typefully
```

### List all skills and their sources

```bash
python3 ~/.dotfiles/config/claude/update-skills --list
```

### Install a new skill

The script clones the skill, detects its name from `SKILL.md`, copies it into the skills directory, and adds an entry to the manifest automatically.

```bash
# Skill is the whole repo
python3 ~/.dotfiles/config/claude/update-skills install https://github.com/user/my-skill

# Skill lives in a subdirectory of a larger repo
python3 ~/.dotfiles/config/claude/update-skills install https://github.com/org/skills-repo --subdir skills/my-skill

# Pin to a specific branch, tag, or commit
python3 ~/.dotfiles/config/claude/update-skills install https://github.com/org/repo --subdir skills/my-skill --ref v2.0.0

# Override the local name (when upstream name differs)
python3 ~/.dotfiles/config/claude/update-skills install https://github.com/org/repo --subdir path/to/skill --name my-local-name
```

### Sync manually added skills

If you copied a skill directory manually, run `sync` to register any untracked directories into the manifest. They will be added with `status: unknown` — edit the manifest to set their git source.

```bash
python3 ~/.dotfiles/config/claude/update-skills sync
```

Skills are also updated automatically when running the main `./update` script.

## Author

Author of original setup [@freekmurze](https://githum.com/freekmurze) (https://github.com/freekmurze/dotfiles). Thanks for this awesome setup. 
