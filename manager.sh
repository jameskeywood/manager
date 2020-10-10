#!/bin/bash

function menu {

choice=$(dialog	--clear \
				--menu "Choose one" 0 0 0 \
					"Select" "Select a preset" \
					"Add" "Add a preset" \
					"Remove" "Remove a preset" \
					"View" "View a preset" \
				--output-fd 1)

case "$choice" in
	"Select")
		index=($(cat config/index.txt))
		preset=$(dialog --clear \
						--menu "Select" 0 0 0 \
							"${index[@]}" \
						--output-fd 1)
		items=($(cat config/presets/"$preset.txt"))
		xwallpaper --zoom "${items[0]}"
		;;
	"Add")
		echo nou
		;;
	"Remove")
		echo hehe
		;;
	"View")
		index=($(cat config/index.txt))
		preset=$(dialog --clear \
						--menu "Select" 0 0 0 \
							"${index[@]}" \
						--output-fd 1)
		dialog --textbox config/presets/"$preset.txt" 0 0
		;;
esac

}

menu

exit 0
