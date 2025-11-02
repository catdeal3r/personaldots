
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config
import qs.services

Singleton {
	id: root
	
	// Load settings from json
	property var settings: jsonAdapterConfig
	property bool isLoaded: false
	
	FileView {
		id: jsonFileSink
		path: Quickshell.shellDir + "/settings/settings.json"
		
		watchChanges: true
		onFileChanged: {
			root.isLoaded = false
			reload()
		}
		
		onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error == FileViewError.FileNotFound) {
                writeAdapter();
            }
        }
        
        onLoaded: {
			root.isLoaded = true
		}
		
        JsonAdapter {
			id: jsonAdapterConfig
			
			property int minutesBetweenHealthNotif: 30
			
			property JsonObject bar: JsonObject {
				property string barLocation: "bottom"
				property bool smoothEdgesShown: false
				property bool workspacesCenterAligned: true
			}

			property string currentWallpaper: Quickshell.shellDir + "/assets/default_blank.png"
			property string previousWallpaper: "null"
			property string secondPreviousWallpaper: "null"
			property string wallpaperToSet: "null"
			
			property string font: "SF Pro Display"
			property string iconFont: "Material Symbols Sharp"
			property int borderRadius: 20

			property int animationSpeed: 200

			property bool usePfpInsteadOfLogo: false
			property string pfpLocation: "~/.face"

			property JsonObject componentControl: JsonObject {
				property bool barIsEnabled: true
				property bool notifsIsEnabled: true
				property bool lockscreenIsEnabled: true
				property bool desktopIsEnabled: true
				property bool launcherIsEnabled: true
			}

			property string nightmodeColourTemp: "4500K"
			property bool nightmodeOnStartup: true
			
			property string weatherLocation: "REPLACE"
			
			onWeatherLocationChanged: {
				Weather.reload()
			}
		}
	}
}
