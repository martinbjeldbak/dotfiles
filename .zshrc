#uzmodload zsh/zprof

source ~/.aliases

# Git credentials
GIT_AUTHOR_NAME="Martin Bjeldbak Madsen"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="me@martinbjeldbak.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

export EDITOR='nvim'
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"


# Fix C-h binding for tmux and vim-tmux-navigator
# https://github.com/christoomey/vim-tmux-navigator/issues/61
# infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
# tic $TERM.ti

# Load zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Load various lib files
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh, defer:3
zplug "plugins/zsh-agent", from:oh-my-zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh

# Ruby
zplug "plugins/rbenv", from:oh-my-zsh

# Python
zplug "plugins/pyenv", from:oh-my-zsh

eval "$(pyenv virtualenv-init -)"

# Node

zplug "lukechilds/zsh-nvm"
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"

# OS specific plugins
# CURRENT_OS=`uname`
# if [[ $CURRENT_OS == 'Darwin' ]]; then
  zplug "lib/*", from:oh-my-zsh
#fi

# zsh-syntax-highlighting must be the last plugin sourced
zplug "zsh-users/zsh-syntax-highlighting", defer:2


# Zsh theme
#zplug mafredri/zsh-async, from:github, defer:0
#zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug romkatv/powerlevel10k, use:powerlevel10k.zsh-theme

zplug load

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/Users/martin/.dotnet/tools"
export PATH="/Users/martin/.ebcli-virtual-env/executables:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export SSH_AUTH_SOCK=/Users/martin/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# eval "$(direnv hook zsh)"
# eval "$(gpg-agent --daemon)"
eval "$(pipenv --completion)"


# zprof

# To customize prompt, run `p9k_configure` or edit ~/.p10k.zsh.
source ~/.p10k.zsh

source <(navi widget zsh)

# Google Cloud Platform sourcing
# source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
# source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

ulimit -S -n 2048
