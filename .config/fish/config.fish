# suppress greetings
set fish_greeting

# default editor
set -gx EDITOR vim

# bind Ctrl+h to accept the default suggestion
bind \ch forward-char

# set tide prompts
set --universal tide_left_prompt_items status context pwd git
set -U tide_right_prompt_items
set -U tide_pwd_truncate_margin 1000000000

# add to PATH ~/.local/bin
set PATH ~/.local/bin $PATH

# # aliases
alias sp="source ~/.config/fish/config.fish"
source ~/.bash_aliases
