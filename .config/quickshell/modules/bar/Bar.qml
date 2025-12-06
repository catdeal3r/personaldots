import Quickshell
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.modules
import qs.modules.bar
import qs.config
import qs.modules.common
import qs.services

Scope {
	signal finished();
	id: root
	
	Variants {
		model: Quickshell.screens;
  
		PanelWindow {
			id: barWindow
		
			property var modelData
			screen: modelData
			
			anchors {
				top: true
				bottom: false
				left: true
				right: true
			}

			color: "transparent"
			
			implicitHeight: 40
			
			visible: true
			
			exclusiveZone: 40
			exclusionMode: ExclusionMode.Auto

			mask: Region {
				item: barBase
			}

			Rectangle {
				id: barBase
				anchors.left: parent.left

				width: barWindow.width
				height: barWindow.implicitHeight
				color: Colours.palette.surface
				

				WorkspacesWidget {}
						
				RowLayout {
					spacing: 15

					//width: 170
					height: parent.height
					anchors.right: parent.right
					anchors.rightMargin: 20
							
					SysTray {
						Layout.preferredHeight: 10
						Layout.preferredWidth: (SystemTray.items.values.length * 25)
						Layout.alignment: Qt.AlignVCenter
						Layout.topMargin: -4

						bar: barWindow
					}	
					
					TimeWidget {
						color: Qt.alpha(Colours.palette.on_surface, 0.8)
					
						font.family: Config.settings.font
						font.weight: 600
								
						font.pixelSize: 13
						Layout.preferredHeight: 19

						Layout.alignment: Qt.AlignVCenter
					}

					NetworkWidget {
						color: Network.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
									
						font.family: Config.settings.iconFont
						font.weight: 600

						Layout.alignment: Qt.AlignVCenter
						Layout.preferredHeight: 20

						font.pixelSize: 15

						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor

							onClicked: Quickshell.execDetached([ `${Quickshell.shellDir}/scripts/network.out` ])
						}

						Behavior on color {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}
					}

					BluetoothWidget {
						color: Bluetooth.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
									
						font.family: Config.settings.iconFont
						font.weight: 600

						Layout.alignment: Qt.AlignVCenter
						Layout.preferredHeight: 20

						font.pixelSize: 15

						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor

							onClicked: Bluetooth.toggle()
						}

						Behavior on color {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}
					}
									
					BatteryWidget {
						color: Qt.alpha(Colours.palette.on_surface, 0.8)

						font.family: Config.settings.iconFont
						font.weight: 600
								
						Layout.alignment: Qt.AlignVCenter
						Layout.preferredHeight: 22
						font.pixelSize: 15
					}
				}
			}
		}
	}
}

