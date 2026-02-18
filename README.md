# Dotfiles

![screenshot](images/setup-screenshot.png)

#### Prerequisites:
Install the following with brew:
* stow
* ghostty
* zoxide
* tmux
* lazygit
* neovim (0.11 or later)
* ripgrep (needed for telescope live grep)
* tree-sitter-cli (needed to download/compile treesitter parsers)

#### Setup via stow:
2. `stow -t ~/.config config`
3. `stow -t ~ zsh`
4. `stow -t ~ tmux`

#### Removing stow created symlinks:
1. `stow -D -t ~/.config config`
2. `stow -D ~ zsh`
3. `stow -D ~ tmux`
