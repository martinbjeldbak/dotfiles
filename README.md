# Martin's dotfiles

![Screenshot of shell prompt](https://user-images.githubusercontent.com/823316/111058538-01553e00-84db-11eb-926b-19c809c0c3c0.png)

This project contains my important dotfiles, backed up using [ira/mackup](https://github.com/lra/mackup) tool.
Previously, I had these files backed up to iCloud. Now they are on git for easier version control. Inspired by [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles).

## Installation

**Warning**: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

You can clone the repository wherever you want. I keep it in `~/Projects/dotfiles`. If you use a different directory, change the `.mackup.cfg` config to point to this directory.

First, install `mackup` with [homebrew](https://github.com/Homebrew/brew), [`oh-my-zsh`](https://ohmyz.sh), and the [powerlevel10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh) ZSH theme.

```sh
brew install git zsh mackup exa neovim
```

Then you can clone the repository and set mackup up to symlink local files to this repository folder.

```sh
git clone https://github.com/martinbjeldbak/dotfiles.git
```

Then copy the mackup configuration file into your local home folder and edit it to point to the location of the folder just cloned.

```sh
cp ~/Projects/dotfiles/.mackup.cfg ~/.mackup.cfg
cat ~/.mackup.cfg
```

We are now ready to symlink local files with this project's. For each file that already exists, a prompt will be shown on whether or not you want to overwrite it with the corresponding file in this repository. Before hitting `y`, make a backup of the file.

```sh
cd ~
mackup restore
```

## Neovim

After installing neovim, let's install packer.nvim as per below instructions

https://github.com/wbthomason/packer.nvim


Then install language parsers for [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter)

```vim
:TSInstall bash css comment dockerfile gitignore go html java javascript jsonnet json jsonc latex make markdown proto python regex rego ruby scss sql typescript vim yaml
```


### Oh My Zsh

Ensure `zsh` is installed on the operating system via a package manager, i.e. apt or brew, then follow the [installation instructions](https://ohmyz.sh/#install) at Oh My Zsh.

Then install custom Oh My Zsh plugins, such as [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md) via

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Set up catppuccin syntax highlighting following <https://github.com/catppuccin/zsh-syntax-highlighting>

### Theme

Currently I'm loving the OneDark theme at https://github.com/joshdick/onedark.vim and have set up this in vim, but it should also be configured for the terminal.

### Fonts

Depending on OS setting up the dotfiles on, install the JetBrains Mono Nerd Fonts as per https://github.com/romkatv/powerlevel10k#manual-font-installation

### Tmux

Install `tmux-plugin-manager` following https://github.com/tmux-plugins/tpm#installation
