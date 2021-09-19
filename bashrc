# ------------------------
# Convenient shell defaults
# ------------------------
export LANG=en_CA.UTF-8

export HISTSIZE=1000000 # Longer history

# Append to the histfile every time we run a command.
# Run `history -n` to refresh the history into the terminal.
PROMPT_COMMAND='history -a'

# Prevent automatic "searching for command..."
unset command_not_found_handle

# ------------------------
# Terminal Prompt
# ------------------------
# Convert hostname to a number from 0 to 9.
ps1_colour=$(
  hostname \
  | md5sum \
  | awk '{print $1}' \
  | tr a-z A-Z \
  | xargs -n1 printf 'ibase=16;%s%%A\n' \
  | bc \
  | xargs -n1 printf '9%s;1m'
)

# \W = Basename of the current directory
# \t = time of day.
# \[ to \] = Wrapper for the colour codes to make things line up.
# Colour from the hash of the current hostname.
export PS1="\[\e[$ps1_colour\][\W \t]\$ \[\e[0m\]"

# ------------------------
# Aliases
# ------------------------

alias sc="systemctl"
alias scu="systemctl --user"
alias jcu="journalctl --user-unit"
alias tf=terraform
alias vim="gvim -v"

# ------------------------
# Completers
# ------------------------

# AWS
complete -C aws_completer aws


# ------------------------
# Handy functions
# ------------------------

# Example:
# for url in $(cat url_list.txt); do
#   max_proc 16
#   curl "$url"
# done
function max_proc() {
  while [ $(jobs | wc -l) -gt $1 ]; do
    sleep 3;
  done
}
