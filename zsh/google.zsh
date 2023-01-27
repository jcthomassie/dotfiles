export CHROME_REMOTE_DESKTOP_RES_LAPTOP="3840x2400" # Lenovo ThinkPad X1 Carbon
export CHROME_REMOTE_DESKTOP_RES_DESK="3840x2160" # Lenovo Monitor
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="$CHROME_REMOTE_DESKTOP_RES_LAPTOP,$CHROME_REMOTE_DESKTOP_RES_DESK"

alias auth="gcertstatus --check_remaining=1h --quiet || gcert"
alias b="blaze"
alias bb="blaze build"
alias bq="blaze query"
alias text-scaling-normal="gsettings set org.gnome.desktop.interface text-scaling-factor 1.0"
alias text-scaling-large="gsettings set org.gnome.desktop.interface text-scaling-factor 1.25"

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    alias crd-laptop="xrandr -s $CHROME_REMOTE_DESKTOP_RES_LAPTOP && sudo /etc/init.d/chrome-remote-desktop restart"
    alias crd-desk="xrandr -s $CHROME_REMOTE_DESKTOP_RES_DESK && sudo /etc/init.d/chrome-remote-desktop restart"
    alias monitor-laptop="text-scaling-normal && crd-laptop"
    alias monitor-desk="text-scaling-large && crd-desk"
else
    alias monitor-laptop="text-scaling-normal"
    alias monitor-desk="text-scaling-large"
fi
