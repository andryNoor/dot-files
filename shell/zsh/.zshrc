# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
## Add rustup completions
#JoolakNET adds this for rustup completions purpose
#JoolaNET also add a folder ~/.zfunc/ for this purpose
#
# $ rustup completions zsh > ~/.zfunc/_rustup
#
# $ rustup completions zsh cargo > ~/.zfunc/_cargo

fpath+=~/.zfunc
## End

compinit

# General Configs
export TERM="xterm-256color"
export LANG="en_US.UTF-8" #JoolakNET add's this
export SUDO_PROMPT="[sudo] password for %p::🔒"
#
# Change default Layout for FZF
export FZF_DEFAULT_OPTS='--height 65% --layout=reverse --border'
export FZF_PREVIEW_ADVANCED=true
export FZF_PREVIEW_WINDOW='right:65%:nohidden'

source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

#antigen theme agnoster
#antigen theme bhilburn/powerlevel9k powerlevel9k
antigen theme romkatv/powerlevel10k
antigen bundle command-not-found
#antigen bundle compleat
antigen bundle git-extras
antigen bundle git-flow
#antigen bundle npm
#antigen bundle web-search
antigen bundle z
#antigen bundle zsh-users/zaw
antigen bundle Aloxaf/fzf-tab
#antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
#antigen bundle zsh-users/zsh-history-substring-search
antigen bundle chrissicool/zsh-256color
antigen bundle gretzky/auto-color-ls
antigen bundle MichaelAquilina/zsh-auto-notify
#{
	## zsh-auto-notify config
	# Set notification expiry to 5 seconds
	export AUTO_NOTIFY_EXPIRE_TIME=5000
	# auto-notify whitelist
	export AUTO_NOTIFY_WHITELIST=("pacui" "pacman-mirrors" "npm" "pip" "gem" "cp" "mv" "rm" "antigen" "docker" "update-grub")
#}
antigen bundle hlissner/zsh-autopair
#{
	##
	AUTOPAIR_INHIBIT_INIT=1
	typeset -gA AUTOPAIR_PAIRS
	AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' ' ' ' ')
	AUTOPAIR_LBOUNDS=(all '[.:/\!]')
	AUTOPAIR_LBOUNDS+=(quotes '[]})a-zA-Z0-9]')
	AUTOPAIR_LBOUNDS+=(spaces '[^{([]')
	AUTOPAIR_LBOUNDS+=(braces '')
	AUTOPAIR_LBOUNDS+=('`' '`')
	AUTOPAIR_LBOUNDS+=('"' '"')
	AUTOPAIR_LBOUNDS+=("'" "'")

	AUTOPAIR_RBOUNDS=(all '[[{(<,.:?/%$!a-zA-Z0-9]')
	AUTOPAIR_RBOUNDS+=(quotes '[a-zA-Z0-9]')
	AUTOPAIR_RBOUNDS+=(spaces '[^]})]')
	AUTOPAIR_RBOUNDS+=(braces '')
#}
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle pip
antigen bundle unixorn/fzf-zsh-plugin@main

antigen apply

# Keybindings
#"^[[A" up-line-or-history
#"^[[B" down-line-or-history
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
#bindkey '^R' zaw-history
#bindkey -M filterselect '^D' zaw-bookmark-add-buffer
#bindkey -M filterselect '^R' down-line-or-history
#bindkey -M filterselect '^S' up-line-or-history
bindkey -v

# ZAW UI
#zstyle ':filter-select:highlight' matched fg=green
#zstyle ':filter-select' max-lines 5
#
# ZSH Configs
# activate menu selection
zstyle ':completion:*' menu select
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
# disable sort when completing 'git checkout'
zstyle ':completion:*:git-checkout:*' sort false
# set description format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
# switch group using ',' and '.'
#zstyle ':fzf-tab:*' switch-group ',' '.'
# How many lines does fzf's prompt occupied (may need to set it to 4 if '--border' of fzf is used)
zstyle ':fzf-tab:complete:*:*' fzf-pad 10
# show systmed unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
# show file content
zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'
export LESSOPEN='| ~/.lessfilter %s'
#
# List all hidden files with fzf-tab
setopt glob_dots
# Show bouth `.` and `..` with fzf-tab
#zstyle ':completion:*' special-dirs true
#Lastly, to prevent duplicate commands in the history file, set histignoredups:
setopt histignoredups

# Set default user
#DEFAULT_USER="hirad"
DEFAULT_USER="andrynoor"

# If you do a 'rm *', Zsh will give you a sanity check!
setopt RM_STAR_WAIT

# Allows you to type Bash style comments on your command line
setopt interactivecomments

# Zsh has a spelling corrector
setopt CORRECT

#by JoolakNET
export PATH="/usr/lib/ccache/bin/:$PATH"
source /usr/share/nvm/init-nvm.sh # init Nodejs Version Manager (NVM)
source /usr/share/zsh/plugins/emoji-cli/emoji-cli.zsh # emoji-cli (Emoji completion for zsh)
export PATH="$PATH":"$HOME/.pub-cache/bin" # Dart Pub installs executabes 
export PATH="$PATH:$HOME/.local/share/flutter/bin/" # flutter
## Aliases:
### colorls
alias lsc='colorls'
alias lss='colorls -A'
alias lsr='colorls -A --report'
alias lsg='colorls -A --git-status'
alias lst='colorls -A -t'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# JoolkaNET add this for Pyenv config (pyenv init)
#eval "$(pyenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/shims:$PATH"
eval "$(pyenv init --path)"

# To customize prompt, run `p10k configure` or edit ~/.wslconfig/.p10k.zsh.
[[ ! -f ~/.wslconfig/.p10k.zsh ]] || source ~/.wslconfig/.p10k.zsh
