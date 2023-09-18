## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

## Export variable need for qt-theme
if type "qtile" >> /dev/null 2>&1
   set -x QT_QPA_PLATFORMTHEME "qt5ct"
end

# Set settings for https://github.com/franciscolourenco/done
## Joolak disable this due to massive delay on WSL fish shell
## (maybe because of it tries to invoke PowerShell first)
#set -U __done_min_cmd_duration 10000
#set -U __done_notification_urgency_level low


## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end


## Starship prompt
#if status --is-interactive
#   source ("/usr/bin/starship" init fish --print-full-init | psub)
#end

## OMF prompt
# neolambda theme prompt:
# To avoid double printing of the virtualenv name in prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT 0
set -g theme_nerd_fonts yes


## Advanced command-not-found hook
source /usr/share/doc/find-the-command/ftc.fish


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'"                                     # show only dotfiles
alias ip="ip -color"

# Replace some more things with better alternatives
#alias cat='bat --style header --style rule --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias upd='pacman -Syu'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                          # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"     # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --verbose --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --verbose --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --verbose --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias please='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"


## Run fastfetch if session is interactive
if status --is-interactive && type -q fastfetch
   fastfetch --load-config ~/.config/fastfetch/presets/dr460nized-distrod
end

## JNET Personalisation
# Pyenv
pyenv init - | source

# PIP search (pip package: pip-search)
# Already moved to ~/.config/fish/functions/pip.fish

# Configure or Change fzf.fish keybindings
# https://github.com/PatrickF1/fzf.fish/blob/main/functions/_fzf_configure_bindings_help.fish
#
# Ctrl-h HISTORY (default: Ctrl-r)
fzf_configure_bindings --history=\ch

# mcfly (Ctrl-r shell History https://github.com/cantino/mcfly/tree/master)
mcfly init fish | source
# set -gx MCFLY_LIGHT TRUE # Light Mode color scheme
set -gx MCFLY_KEY_SCHEME vim # Vim Key bindings (default: emacs)
set -gx MCFLY_FUZZY 2 # Fuzzy Searching (2 - 5 value gives good result)
set -gx MCFLY_INTERFACE_VIEW TOP # Interface View (default: TOP, option: TOP and BOTTOM)
# set -gx MCFLY_DISABLE_MENU TRUE # Diable Menu Interface
set -gx MCFLY_RESULTS_SORT LAST_RUN # Results Sorting (default: RANK, option: RANK, LAST_RUN)
# set -gx MCFLY_PROMPT "❯" # Custom Prompt (default: "$")

# Pure-fish config (omf prompt theme)
# set --universal pure_symbol_prompt "λ"
# set --universal pure_symbol_prompt " λ"
set --universal pure_symbol_prompt "λ  "
# set --universal pure_symbol_prompt " "
# set --universal pure_symbol_prompt " λ" 
# set --universal pure_symbol_prompt "╰─λ"
# set --universal pure_symbol_ssh_prefix ""
set --universal pure_symbol_container_prefix " "
# set --universal pure_symbol_virtualenv_prefix ""
set --universal pure_reverse_prompt_symbol_in_vimode true # default: true
set --universal pure_separate_prompt_on_error false # default: false
set --universal pure_show_jobs true # default: false
set --universal pure_show_prefix_root_prompt true # default: false

