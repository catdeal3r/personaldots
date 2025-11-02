
pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

Singleton {
	id: root
	
	function setNewWallpaper(path) {
		Config.settings.secondPreviousWallpaper = `${Config.settings.previousWallpaper}`;
		Config.settings.previousWallpaper = `${Config.settings.currentWallpaper}`;
		Config.settings.wallpaperToSet = `${path}`;
	}
	
	function changeColourProp() {
		Quickshell.execDetached(["matugen", "--type", `${Config.settings.colours.genType}`, "--mode", `${Config.settings.colours.mode}`, "image", `${Config.settings.currentWallpaper}`]);
	}
}
