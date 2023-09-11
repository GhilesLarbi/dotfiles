export PATH=$PATH:$HOME/.local/bin

# get ride of gtk at-spy spoky thin'
export NO_AT_BRIDGE=1

# prevent display kernel threads in top
export LIBPROC_HIDE_KERNEL=true

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"

# Clean-up
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
