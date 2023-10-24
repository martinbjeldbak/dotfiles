# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  path+="$HOME/.local/bin"
fi

path+="$HOME/.yarn/bin"

source $HOME/.exports

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

BAT_THEME="Catppuccin-frappe"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux asdf fzf ripgrep gh terraform helm golang kubectl docker docker-compose gcloud history mvn macos jira z zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

#RPS1='$(kubectx_prompt_info)'
#RPROMPT='$(tf_prompt_info)'

### History
# Source: https://github.com/craigjperry2/dotfiles/blob/aa77ddcbde63bf3a0a61a2c218bf36f8e146a3c9/dotfiles/zshrc#L44
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

# You may need to manually set your language environment
export LANG=en_AU.UTF-8

export EDITOR='nvim'

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# Google Cloud completions
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Poetry completions https://python-poetry.org/docs/
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# Pytest completions https://docs.pytest.org/en/7.1.x/how-to/bash-completion.html
# register-python-argcomplete pytest

# Source: https://github.com/zsh-users/zsh-syntax-highlighting/issues/295#issuecomment-214581607
# Improve paste performance
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

case `uname` in
  Darwin) # MacOS

    if [[ $(arch) == 'arm64' ]]; then # M1
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    else
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi

    # Support switching JDK versions https://github.com/AdoptOpenJDK/homebrew-openjdk#switch-between-different-jdk-versions
    jdk() {
      version=$1
      export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
      java -version
    }

    # Set default to java 8
    export JAVA_HOME=$(/usr/libexec/java_home -v"11");

    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

    # Add gcloud components to your PATH, add this to your profile
    source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
    source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

    path+=("/usr/local/opt/curl/bin")
    ;;
  Linux)
    source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh
    source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
esac

export PATH

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Override any oh-my-zsh aliases
source $HOME/.aliases
