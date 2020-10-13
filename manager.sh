#!/bin/bash

# Visual setting manager
# James Keywood - 13/Oct/2020

function menu {

# opens a dialog menu to take a user choice
choice=$(dialog	--clear \
				--menu "Choose one" 0 0 0 \
					"Select" "Select a preset" \
					"Add" "Add a preset" \
					"Remove" "Remove a preset" \
					"View" "View a preset" \
				--output-fd 1)

# initiates a new dialog box depending on option
case "$choice" in

	# allow's the user to select a preset
	"Select")
		index=($(cat config/index.txt)) # array for index file
		# creates dialog menu for the user to select their preset
		preset=$(dialog	--clear \
						--menu "Select" 0 0 0 \
							"${index[@]}" \
						--output-fd 1)
		items=($(cat config/presets/"$preset.txt")) # array for config file
		xwallpaper --zoom "${items[0]}" # sets the wallpaper
		;;

	# allow's the user to add a preset
	"Add")
		# creates dialog menus for the user to add preset details
		name=$(dialog	--clear \
						--inputbox "Enter a name" 0 0 \
						--output-fd 1)
		name=$(echo -e "$name" | tr -d '[:space:]') # removes whitespace
		desc=$(dialog	--clear \
						--inputbox "Enter a description" 0 0 \
						--output-fd 1)
		desc=$(echo -e "$desc" | tr -d '[:space:]') # removes whitespace
		path=$(dialog	--clear \
						--inputbox "Enter a wallpaper path" 0 0 \
						--output-fd 1)
		path=$(echo -e "$path" | tr -d '[:space:]') # removes whitespace
		echo -e "$name" >> config/index.txt
		echo -e "$desc" >> config/index.txt
		touch config/presets/"$name.txt"
		echo -e "$path" >> config/presets/"$name.txt"

		;;

	# allow's the user to remove a preset
	"Remove")
			index=($(cat config/index.txt)) # array for index file
			# creates dialog menu for the user to select the preset to remove
			preset=$(dialog	--clear \
							--menu "Remove" 0 0 0 \
								"${index[@]}" \
							--output-fd 1)
			# remove preset and description from index file
			sed -i "/$preset/,+1 d" config/index.txt
			rm config/presets/"$preset.txt" # remove config file
			;;

	# allow's the user to view a preset config file
	"View")
		index=($(cat config/index.txt)) # array for index file
		# creates dialog menu for the user to select the preset to view
		preset=$(dialog	--clear \
						--menu "View" 0 0 0 \
							"${index[@]}" \
						--output-fd 1)
		# creates dialog textbox for the user to view the config file
		dialog --textbox config/presets/"$preset.txt" 0 0
		;;

	*)
		echo exit
		;;
esac

}

menu

exit 0
