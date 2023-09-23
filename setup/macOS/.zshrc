### Python 
alias python3=/usr/local/bin/python3

### Conda Environment

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pascal/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pascal/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pascal/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pascal/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=$PATH:/opt/opt/anaconda3/bin/conda

### Aliases

# Euler Connection ETH
#alias mounteuler="sshfs passutte@euler.ethz.ch:/cluster/home/passutte/machine_perception /Users/pascal/Developer/ETH/Machine_Perception/Perceptrons/"
#alias umounteuler="umount -f /Users/pascal/Developer/ETH/Machine_Perception/Perceptrons"

# general
alias sp="source ~/.zshrc"
alias b="cd .."
alias c="clear"

# git 
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git pull"
alias gd="git diff"

# mkdir with date/time stamp
alias mkdir-date="mkdir $(date +\"%Y-%m-%d\")"
alias mkdir-time="mkdir $(date +\"%H_%M_%S\")"
alias mkdir-comb-date-time="mkdir $(date +\"%Y-%m-%d-%H_%M_%S\")"



