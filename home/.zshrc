source "$HOME/.zshenv"
source "$HOME/.antigen/antigen.zsh"

# Load the oh-my-zsh's library.
# antigen use oh-my-zsh
antigen bundle robbyrussell/oh-my-zsh lib/

antigen bundles <<EOBUNDLES
  # Git and github autocompletions and aliases
  git
  # git-extras

  # Tools of the trade
  # brew
  # gem
  # capistrano

  # More tools
  # vagrant
  # tmux

  # Meta
  # tmuxinator
  # command-not-found
  # zsh-users/zsh-syntax-highlighting
  # colored-man
  # history
  # history-substring-search

  git-flow

  sindresorhus/pure

  rupa/z
EOBUNDLES

# Tracks your most used directories, based on 'frecency'. And its accompanying
# setup code.
# antigen-bundle z
# antigen bundle sindresorhus/pure
# add-zsh-hook precmd _z_precmd
# function _z_precmd {
#     _z --add "$PWD"
# }

# Load the theme.
# antigen theme desyncr/zshrc themes/af-magic-mod

# Tell antigen that you're done.
antigen apply

# antigen-update
# antigen-selfupdate

# Customize to your needs...
alias mvim="reattach-to-user-namespace mvim"
alias vim="reattach-to-user-namespace mvim -v"
alias work="cd ~/Sites $1"
alias reload="source ~/.zshrc"
alias gff="git flow feature"
alias gffc="git flow feature checkout"
alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gffp="git flow feature publish"
alias gfft="git flow feature track"
alias ppr="git flow feature publish \$(current_branch) && hub pull-request"

setopt nonomatch
# export PATH=/usr/local/bin:/usr/local/share/npm/bin:$PATH:~/bin
# export PATH=$PATH:/Users/jgrau/pear/bin

### Added by the Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"
export DEFAULT_USER=jgrau
export EDITOR='vim'

# eval "$(direnv hook zsh)"
