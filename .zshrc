# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
# export ZSH="/usr/share/zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
# ZSH_THEME="rkj-repos-modified"
# ZSH_THEME="jnrowe"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  archlinux
  colored-man-pages
  docker
  docker-compose
  fzf
  git
  grc
  pip
  rust
  sudo
  systemd
  you-should-use
  # zbell
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# make sure no plugin fucks with my PATH
OLDPATH=$PATH
source $ZSH/oh-my-zsh.sh
export PATH=$OLDPATH

# Plugin configuration

## ZSH autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
bindkey '^j' autosuggest-execute
bindkey '^h' autosuggest-accept

## zbell
zbell_duration=30
zbell_ignore=(
  $EDITOR
  v
  $PAGER
  ssh
  r
  ranger
  nvim
  chezmoi
  docker compose exec
)

# User configuration
export EDITOR="nvim"

# No bell: Shut up Zsh
unsetopt beep

# Pretend to be xterm for ssh connections
export TERM="xterm-256color"

# Disable F13 inserting garbage characters
bindkey -s "\e[25~" ""

export GTK_THEME=Adwaita:dark

alias gib="xclip -selection c"
alias take="xclip -selection c -o"
alias cr="cargo run"
alias ct="cargo test"
alias cl="cargo clippy"
alias v="/usr/bin/nvim"
alias p="python"
alias r="ranger"
alias c="cargo"
alias sr="source ranger"
alias cm="cmatrix -a -u3"
alias btc="bluetoothctl"
alias rs="source ~/.zshrc"
alias fv='v $(fzf)'
alias xev='xev | grep "keycode"'
alias wtf='journalctl -r'
alias samedir='(cd $(pwd); $TERMINAL)  >/dev/null 2>&1 &!'
alias suspend='systemctl suspend'
alias zconf="nvim ~/.zshrc"
alias aconf="nvim ~/.config/awesome/rc.lua"
alias atconf="nvim ~/.config/awesome/themes/hulks-dark/theme.lua"
alias vconf="(cd ~/.config/nvim; nvim ~/.config/nvim/init.lua)"
# ssh
alias vpsr="ssh root@141.98.155.60"
alias vps="ssh hannemann@141.98.155.60"

alias gwipco='git commit --no-verify --no-gpg-sign -m '\''--wip-- [skip ci]'\'
alias watchdiff="watch -c git diff --color=always"

alias cdiff="diff --color=always"

alias http="python -m http.server 8080"
alias ci="cargo build --all-features && cargo test --all-features && cargo clippy --all-features --profile dev -- -D warnings && cargo fmt --check"

alias films="curl -sS https://writemd.rz.tuhh.de/P_wASTksR7OdY0aVfZPBOg/download | awk '/^#/{f=0} f * NF; /## Common/{f=1}'"
alias filmrng="films | shuf -n 1"

alias enter-mindworks="docker compose exec -ti -u mindworks php bash"
alias ssh-preview="ssh -o "IdentitiesOnly=yes" -i ~/.ssh/preview mindworks@192.168.254.5"

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --ignore-file ~/.ignore 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

samedir-widget() {
  samedir
}
zle -N samedir-widget
bindkey '^n' samedir-widget

function gwa()
{
  NAME="$(basename $(command git worktree list | head -n1 | cut -d' ' -f1))-$1"
  NEW_WORKTREE_PATH="$(command git worktree list | head -n1 | cut -d' ' -f1)/../$NAME"
  command git worktree add "$NEW_WORKTREE_PATH" "$(git rev-parse HEAD)"
  cd "$NEW_WORKTREE_PATH"
}
alias gwl="git worktree list"
function gwj
{
  WORKTREE="$(git worktree list | fzf | cut -d' ' -f1)"
  cd $WORKTREE
}
function gwd
{
  ORIGINAL_WORKTREE="$(git worktree list | head -n1 | cut -d' ' -f1)"
  command git worktree remove "$(pwd)" && cd $ORIGINAL_WORKTREE
}

function mcdir
{
    command mkdir $1 && cd $1
}

function vw
{
    command nvim $(which $1)
}

function pac
{
    source ~/.venv/$1/bin/activate
}

function gms
{
    trackingBranch=$1
    git merge --squash $trackingBranch
    git commit -m "squashed $trackingBranch"
}

function alert
{
    tee -p >&2 | sed '/^[[:blank:]]*$/d' | tail -"${1:-1}" | sed 's/\x1b\[[0-9;]*m//g' | xargs -I {} notify-send "${3:-Command finished}" " {}" -u ${2:-normal} -t ${4:-5000}
}

function ssh-intranet
{
	gcloud compute ssh --zone "europe-west4-a" "phannemann@$1" --project "intranet-368421"
}

BASE16_SHELL=$HOME/.config/base16-shell/
BASE16_SHELL_SET_BACKGROUND=false
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

export ZSH_AUTOSUGGEST_USE_ASYNC=1

eval "$(starship init zsh)"
