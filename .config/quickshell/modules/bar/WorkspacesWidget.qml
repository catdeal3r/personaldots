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

	

	Rectangle {
		anchors.left: parent.left
		anchors.top: parent.top

		anchors.topMargin: 13
		anchors.leftMargin: 10.5 + (wIndex * (25 + 5 + 4)) + (wIndex - 1)

		width: 8
		height: 8

		color: Colours.palette.on_surface

		Behavior on anchors.leftMargin {
			PropertyAnimation {
				duration: Config.settings.animationSpeed
				easing.type: Easing.InSine
			}
		}

		radius: 1000
	}

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

				Layout.preferredWidth: 25
				Layout.preferredHeight: Layout.preferredWidth
				color: "transparent"

				Text {
					anchors.centerIn: parent
					text: "circle"
					color: !Workspaces.niriWorkspaces[index].is_focused ? Qt.alpha(Colours.palette.on_surface, 0.6) : Colours.palette.on_surface

					Behavior on color {
						PropertyAnimation {
							duration: Config.settings.animationSpeed
							easing.type: Easing.InSine
						}
					}

					font.family: Config.settings.iconFont
					font.pixelSize: 17
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

		Rectangle {
			Layout.fillWidth: true
			Layout.preferredHeight: 10
			color: "transparent"
		}
	}
}
