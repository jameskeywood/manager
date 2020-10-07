#!/bin/bash

function menu {


choice=$(

	dialog	--menu "Choose one" 0 0 0 \
		Select "- Select a preset" \
		Add "- Add a preset" \
		Remove "- Remove a preset" \
		View "- View a preset" )

case "$choice" in
	"Select")
		echo help
		;;
	"Add")
		echo nou
		;;
	"Remove")
		echo hehe
		;;
	"View")
		echo lmao
		;;
	*)
		echo somethingeles
esac

}

menu

exit 0
