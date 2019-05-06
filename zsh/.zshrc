# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="alanpeabody"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)


if [ -f ~/pre.zshrc ]; then
  source ~/pre.zshrc
fi
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="$PATH:$HOME/.rvm/bin:$HOME/.rbenv/shims"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

function cdp {
  path_supplied=`pwd`
  project_path=`basedirname $path_supplied`
  cd $project_path
}


function basedirname {
    return_path=`expr $1`
    dir_name=`dirname $return_path`
    if [ "$dir_name" = "$HOME/src" ]
    then
        echo $return_path
    else
        echo `basedirname $dir_name`
    fi
}

function cds {
  project=$1
  oldIFS=$IFS
  currentPath=""
  IFS=$":"; for p in `echo "$PRO_PATH"`; do
    if [ -d "$p/$project" ]; then
      currentPath="$p/$project"
      break
    fi
  done; IFS=$oldIFS
  if [ ! -z "$currentPath" ]; then
    cd $currentPath
  fi
}

compctl -/ -W "(`echo $PRO_PATH | tr ":" " "`)" cds
function gitout {
 current_branch=`git rev-parse --abbrev-ref HEAD` && git checkout master && git branch -D $current_branch && git remote prune origin && git fetch upstream && git fetch origin && git reset --ha     rd upstream/master && git push && cap uat deploy
}

function git_init {
  repo=`git remote -v | grep fetch | cut -f 2 | cut -d " " -f 1 | awk -F/ '{print $(NF)}'`
  for i in `git remote`; do git remote remove $i; done
  git remote add origin git@github.com:manvil/$repo
  git remote add upstream git@github.com:red-ant/$repo
}

function gitout {
  current_branch=`git rev-parse --abbrev-ref HEAD` && git checkout master && git branch -D $current_branch && git remote prune origin && git fetch upstream && git fetch origin && git reset --hard upstream/master && git push && cap uat deploy
}

bindkey -e
bindkey '[C' forward-word
bindkey '[D' backward-word

function gitlatest {
  git checkout master && git fetch upstream && git fetch origin && git reset --hard upstream/master && git push origin master && git remote prune origin
}
SSH_ENV="$HOME/.ssh/environment"
# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
    find $HOME/.ssh -name "*.pem" -exec /usr/bin/ssh-add {} \;
}

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent> /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

if [ -f ~/post.zshrc ]; then
  source ~/post.zshrc
fi
