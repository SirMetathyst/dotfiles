#!/bin/sh

export MOZ_ENABLE_WAYLAND="1"
#export WAYLAND_DISPLAY="1"
export XDG_CURRENT_DESKTOP="sway"
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM="wayland-egl"
export MESA_LOADER_DRIVER_OVERRIDE="crocus"

if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/tmp/$(id -u)-runtime-dir
	if ! test -d "${XDG_RUNTIME_DIR}"; then
		mkdir "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

if test -z "$DISPLAY" && [ "$(tty)" = "/dev/tty1" ]; then
	dbus-run-session -- sway
fi


alias ls="ls -la"

# APK
alias apk-upgrade="doas apk update && doas apk upgrade"
alias apk-add="doas apk add"

# FLATPAK APPS
alias firefox="flatpak run org.mozilla.firefox"



alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no

for f in "$HOME"/.profile.d/*; do
	# shellcheck source=/dev/null
	. "$f"
done
