#!/bin/sh


case "$1" in
    lock)
        betterlockscreen -l dimblur -- --time-str="%H:%M"
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        systemctl suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
        exit 2
esac

exit 0