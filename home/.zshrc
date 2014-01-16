# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="macovsky"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras brew cap gem github lighthouse osx ruby textmate git-flow heroku powder rake vi-mode)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
alias work="cd ~/Sites $1"
alias reload="source ~/.zshrc"
setopt nonomatch
export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH:~/bin
export PATH=$PATH:/Users/jgrau/pear/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/jgrau/.travis/travis.sh ] && source /Users/jgrau/.travis/travis.sh
