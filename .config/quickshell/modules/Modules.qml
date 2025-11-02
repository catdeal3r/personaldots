import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.bar
import qs.modules.launcher
import qs.modules.lockscreen
import qs.modules.notificationslist
import qs.modules.desktop

Scope {
	Loader {
		active: Config.settings.componentControl.notifsIsEnabled
		sourceComponent: NotificationList {}
	}
	
	Loader {
		active: Config.settings.componentControl.barIsEnabled

		sourceComponent: Loader {
			active: IPCLoader.isBarOpen
			
			sourceComponent: Bar {
				onFinished: IPCLoader.toggleBar()
			}
		}
	}

	Loader {
		active: Config.settings.componentControl.launcherIsEnabled

		sourceComponent: Launcher {
			isLauncherOpen: IPCLoader.isLauncherOpen
		}
	}
		
	Loader {
		active: Config.settings.componentControl.lockscreenIsEnabled

		sourceComponent: Lockscreen {}
	}

	Loader {
		active: Config.settings.componentControl.desktopIsEnabled

		sourceComponent: Desktop {}
	}
}
