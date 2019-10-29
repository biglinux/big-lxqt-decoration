#!/bin/bash

#Translation
export TEXTDOMAINDIR="/usr/share/locale"
export TEXTDOMAIN=biglinux-themes

windowID="$(xprop -root '\t$0' _NET_ACTIVE_WINDOW | cut -f 2)"


if [ "$XDG_CURRENT_DESKTOP" = "LXQt" ]; then

	if [ "$(cat $HOME/.config/lxqt/session.conf | grep kwin_x11)" != "" ]; then
    	kdialog --attach="$windowID" --msgbox $"Kwin já Aplicado!"
    	exit
	else
		cp /etc/xdg/autostart/lxqt-compton.desktop $HOME/.config/autostart
	    echo "Hidden=true" >> $HOME/.config/autostart/lxqt-compton.desktop
	    if [ "$(ps -C compiz | tail -n1 | grep compiz)" != "" ]; then
	    	sed -i 's|window_manager=compiz|window_manager=kwin_x11|g' $HOME/.config/lxqt/session.conf
	    	killall compiz
	    	killall emerald
	    	pcmanfm-qt --desktop-off
	   else
	    	sed -i 's|window_manager=openbox|window_manager=kwin_x11|g' $HOME/.config/lxqt/session.conf
	    	openbox --exit
	        killall usrbincompton
	        pcmanfm-qt --desktop-off
	    fi
	    sleep 2
		kwin_x11 --replace &
		sleep 2
		cd $HOME
		pcmanfm-qt --desktop --profile=lxqt &
		sleep 3
		kdialog --attach="$windowID" --msgbox $"Decoração Aplicada!"       
		exit
	fi
else
	cp /etc/xdg/autostart/lxqt-compton.desktop $HOME/.config/autostart
	echo "Hidden=true" >> $HOME/.config/autostart/lxqt-compton.desktop
	sed -i 's|window_manager=.*|window_manager=kwin_x11|g' $HOME/.config/lxqt/session.conf
	kdialog --attach="$windowID" --msgbox $"Você está no KDE Plasma! Faça o login no LXQt para ver a alteração."
	exit
fi	
