export CHROME_REMOTE_DESKTOP_RES_LAPTOP="3840x2400" # Lenovo ThinkPad X1 Carbon
export CHROME_REMOTE_DESKTOP_RES_DESK="3840x2160" # Lenovo Monitor
export CHROME_REMOTE_DESKTOP_RES_HOME="2560x1440" # LG Monitor
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES="$CHROME_REMOTE_DESKTOP_RES_LAPTOP,$CHROME_REMOTE_DESKTOP_RES_DESK,$CHROME_REMOTE_DESKTOP_RES_HOME"
export ANDROID_ROOT_DIR="$HOME/android"

function set-crd-res {
    xrandr -s "${1:?Missing argument RESOLUTION}"
    sudo /etc/init.d/chrome-remote-desktop restart
}

function setup-android-branch {
    local branch="${1:?Missing argument BRANCH}"
    local branch_dir="$ANDROID_ROOT_DIR/$branch"
    if [[ -d $branch_dir ]]; then
        echo "$branch_dir already exists"
    else
        mkdir $branch_dir
        cd $branch_dir
        repo init -c -u sso://googleplex-android/platform/manifest -b $branch --use-superproject --partial-clone --partial-clone-exclude=platform/frameworks/base --clone-filter=blob:limit=10M
        repo sync -c -j64
    fi
}

alias apk-meta="aapt dump badging"
alias auth="gcertstatus --check_remaining=1h --quiet || gcert"
alias adb-dump="adb shell dumpsys package"
alias adb-log="adb logcat -b all -v color"
alias adb-skip-setup="adb root && adb shell am start -a com.android.setupwizard.FOUR_CORNER_EXIT"
alias adb-set="adb shell setprop"
alias b="blaze"
alias bb="blaze build"
alias bq="blaze query"
alias text-scaling-normal="gsettings set org.gnome.desktop.interface text-scaling-factor 1.0"
alias text-scaling-large="gsettings set org.gnome.desktop.interface text-scaling-factor 1.25"

case "$(hostname -s)" in
    "julianth") # cloudtop
        alias monitor-laptop="text-scaling-normal && set-crd-res $CHROME_REMOTE_DESKTOP_RES_LAPTOP"
        alias monitor-desk="text-scaling-large && set-crd-res $CHROME_REMOTE_DESKTOP_RES_DESK"
        alias monitor-home="text-scaling-normal && set-crd-res $CHROME_REMOTE_DESKTOP_RES_HOME"
        # Call when $CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES is changed
        alias crd-restart="sudo systemctl restart chrome-remote-desktop@$USER.service"
        ;;

    "julianth-glaptop") # laptop
        alias monitor-laptop="text-scaling-normal"
        alias monitor-desk="text-scaling-large"
        alias monitor-home="text-scaling-normal"
        ;;
esac
