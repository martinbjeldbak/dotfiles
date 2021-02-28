# Martin's dotfiles

![Screenshot of shell prompt](https://user-images.githubusercontent.com/823316/109407002-39cc2680-79c9-11eb-9507-8d8a863bd46d.png)

This project contains my important dotfiles, backed up using [ira/mackup](https://github.com/lra/mackup) tool.
Previously, I had these files backed up to iCloud. Now they are on git for easier version control. Inspired by [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles).

## Installation

**Warning**: If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git

You can clone the repository wherever you want. I keep it in `~/Projects/dotfiles`. If you use a different directory, change the `.mackup.cfg` config to point to this directory.

First, install `mackup` with [homebrew](https://github.com/Homebrew/brew).

```sh
brew install mackup
```

```sh
git clone https://github.com/martinbjeldbak/dotfiles.git
mackup restore
```
