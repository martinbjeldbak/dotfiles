# Martin's dotfiles

![Screenshot of shell prompt](https://user-images.githubusercontent.com/823316/111058538-01553e00-84db-11eb-926b-19c809c0c3c0.png)

This project contains my important dotfiles, backed up using [ira/mackup](https://github.com/lra/mackup) tool.
Previously, I had these files backed up to iCloud. Now they are on git for easier version control. Inspired by [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles).

## Installation

**Warning**: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git

You can clone the repository wherever you want. I keep it in `~/Projects/dotfiles`. If you use a different directory, change the `.mackup.cfg` config to point to this directory.

First, install `mackup` with [homebrew](https://github.com/Homebrew/brew) and [`oh-my-zsh`](https://ohmyz.sh).

```sh
brew install mackup
```

Then you can clone the repository and set mackup up to symlink local files to this repository folder.

```sh
git clone https://github.com/martinbjeldbak/dotfiles.git
mackup restore
```
