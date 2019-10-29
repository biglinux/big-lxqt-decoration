#!/bin/bash

#Translation
export TEXTDOMAINDIR="/usr/share/locale"
export TEXTDOMAIN=biglinux-themes

windowID="$(xprop -root '\t$0' _NET_ACTIVE_WINDOW | cut -f 2)"


if [ "$XDG_CURRENT_DESKTOP" = "LXQt" ]; then

	if [ "$(cat $HOME/.config/lxqt/session.conf | grep openbox)" != "" ]; then
	    kdialog --attach="$windowID" --msgbox $"Openbox já Aplicado!"
	    exit
	else
	    rm $HOME/.config/autostart/lxqt-compton.desktop
	    if [ "$(ps -C kwin_x11 | tail -n1 | grep kwin_x11)" != "" ]; then
	    	sed -i 's|window_manager=kwin_x11|window_manager=openbox|g' $HOME/.config/lxqt/session.conf
	    	killall kwin_x11
	    	pcmanfm-qt --desktop-off
	   else
	    	sed -i 's|window_manager=compiz|window_manager=openbox|g' $HOME/.config/lxqt/session.conf
	    	killall compiz
	    	killall emerald
	        pcmanfm-qt --desktop-off
	    fi
	    sleep 2
		openbox --replace --config-file $HOME/.config/openbox/lxqt-rc.xml &
		compton --dbus &
		sleep 2
		cd $HOME
		pcmanfm-qt --desktop --profile=lxqt &
		sleep 3
		kdialog --attach="$windowID" --msgbox $"Decoração Aplicada!"
		exit
	fi	
else
	rm $HOME/.config/autostart/lxqt-compton.desktop
	sed -i 's|window_manager=.*|window_manager=openbox|g' $HOME/.config/lxqt/session.conf
	kdialog --attach="$windowID" --msgbox $"Você está no KDE Plasma! Faça o login no LXQt para ver a alteração."
	exit
fi

