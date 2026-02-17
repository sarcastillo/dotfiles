source /usr/share/cachyos-fish-config/cachyos-config.fish
zoxide init fish | source
atuin init fish | source
oh-my-posh init fish --config kushal | source

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx TERMINAL kitty

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Added by installer
export PATH="/home/sar/.local/bin:$PATH"
