#!/bin/bash

#Translation
export TEXTDOMAINDIR="/usr/share/locale"
export TEXTDOMAIN=biglinux-themes

windowID="$(xprop -root '\t$0' _NET_ACTIVE_WINDOW | cut -f 2)"


if [ "$XDG_CURRENT_DESKTOP" = "LXQt" ]; then

	if [ "$(cat $HOME/.config/lxqt/session.conf | grep compiz)" != "" ]; then
        kdialog --attach="$windowID" --msgbox $"Compiz já Aplicado!"
        exit
	else

	    echo "Hidden=true" >> $HOME/.config/autostart/lxqt-compton.desktop
	    if [ "$(ps -C kwin_x11 | tail -n1 | grep kwin_x11)" != "" ]; then
	    	sed -i 's|window_manager=kwin_x11|window_manager=compiz|g' $HOME/.config/lxqt/session.conf
	    	killall kwin_x11
	    	pcmanfm-qt --desktop-off
	   else
	    	sed -i 's|window_manager=openbox|window_manager=compiz|g' $HOME/.config/lxqt/session.conf
	    	openbox --exit
	        killall usrbincompton
	        pcmanfm-qt --desktop-off
	    fi
	    sleep 2
		compiz --replace &
		sleep 2
		cd $HOME
		pcmanfm-qt --desktop --profile=lxqt &
	    sleep 3
		kdialog --attach="$windowID" --msgbox $"Decoração Aplicada!"       
		exit	
	fi
else
	echo "Hidden=true" >> $HOME/.config/autostart/lxqt-compton.desktop
	sed -i 's|window_manager=.*|window_manager=kwin_x11|g' $HOME/.config/lxqt/session.conf
	kdialog --attach="$windowID" --msgbox $"Você está no KDE Plasma! Faça o login no LXQt para ver a alteração."
	exit
fi	
