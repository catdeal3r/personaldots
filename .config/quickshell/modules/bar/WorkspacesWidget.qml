import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.modules.common

Rectangle {
	id: root
	property int wIndex: 0

	width: parent.width - 200
	height: 40
	color: "transparent"

	anchors.left: parent.left
	anchors.leftMargin: 20			


	property int workspaceCount: 5

	RowLayout {
		anchors.fill: parent
		spacing: 10

		Repeater {
			model: Workspaces.niriWorkspaces

			Rectangle {
				Component.onCompleted: {
					if (Workspaces.niriWorkspaces[index].is_focused) {
						root.wIndex = index
					}
				}

				property bool hovered: false

				Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
				Layout.topMargin: -5
				Layout.fillWidth: false
				Layout.horizontalStretchFactor: 0
				Layout.leftMargin: 0
				Layout.rightMargin: 0

				Layout.preferredWidth: 10
				Layout.preferredHeight: Layout.preferredWidth
				color: hovered ? Qt.alpha(Colours.palette.outline, 0.7) : Qt.alpha(Colours.palette.outline, 0.5)

				radius: 10000

				Behavior on color {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
					cursorShape: Qt.PointingHandCursor

					onClicked: Quickshell.execDetached([ "niri", "msg", "action", "focus-workspace", `${index + 1}`])
					onEntered: parent.hovered = true
					onExited: parent.hovered = false
				}
			}
		}

		Rectangle {
			Layout.fillWidth: true
			Layout.preferredHeight: 10
			color: "transparent"
		}
	}

	Rectangle {
		anchors.left: parent.left
		anchors.top: parent.top

		anchors.topMargin: 13
		anchors.leftMargin: (wIndex * 19) + (wIndex - 1)

		width: 10
		height: 10

		color: Colours.palette.on_surface

		Behavior on anchors.leftMargin {
			PropertyAnimation {
				duration: Config.settings.animationSpeed
				easing.type: Easing.InSine
			}
		}

		radius: 1000
	}
}
