import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	width: 20 * (Workspaces.niriWorkspaces?.length) + 5 * (Workspaces.niriWorkspaces?.length - 1) + 20
	height: 40
	color: "transparent"

	anchors.left: parent.left
	anchors.leftMargin: 20			


	property int workspaceCount: 5

	Behavior on anchors.topMargin {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}

	RowLayout {
		anchors.fill: parent
		spacing: 5

		Repeater {
			model: Workspaces.niriWorkspaces

			Rectangle {
				property bool hovered: false

				Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
				Layout.preferredHeight: root.height
				Layout.topMargin: -5

				Layout.preferredWidth: 20
				color: "transparent"

				Text {
					anchors.centerIn: parent
					text: !Workspaces.niriWorkspaces[index].is_focused ? "square" : "dialogs"
					color: !Workspaces.niriWorkspaces[index].is_focused ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.on_surface

					Behavior on color {
						PropertyAnimation {
							duration: Config.settings.animationSpeed
							easing.type: Easing.InSine
						}
					}

					font.family: Config.settings.iconFont
					font.pixelSize: 16
					font.weight: 600
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					onEntered: parent.hovered = true
					onExited: parent.hovered = false
				}
			}
		}
	}
}
