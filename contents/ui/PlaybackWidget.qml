// -*- coding: iso-8859-1 -*-
/*
 *   Author: audoban <audoban@openmailbox.org>
 *   Date: jue may 1 2014, 13:05:43
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore
import "plasmapackage:/ui/" as PlayBar

PlaybackItem{
    id: playbackWidget

	property int buttonSize: 24

	property alias spacing: content.spacing

	width: content.width + ( model.itemAt(2).visible ? 0 : 20 )

	height: childrenRect.height

	Component.onCompleted: {
		model.itemAt(0).clicked.connect(previous)
		model.itemAt(1).clicked.connect(playPause)
		model.itemAt(2).clicked.connect(stop)
		model.itemAt(3).clicked.connect(next)
	}

	ListModel{
		id: playmodel
		ListElement{
			idIcon: "skip-backward"
			idContour: "contour-skip"
		}
		ListElement{
			idIcon: "playback-start"
			idContour: "contour-playback"
		}
		ListElement{
			idIcon: "playback-stop"
			idContour: "contour-playback"
		}
		ListElement{
			idIcon: "skip-forward"
			idContour: "contour-skip"
		}
	}

	Component{
		id: buttonDelegate

		Item{
			width: childrenRect.width
			height: childrenRect.height

			anchors.verticalCenter: parent.verticalCenter

			property alias elementId: media.elementId

 			property variant image:
				plasmoid.readConfig("opaqueIcons") == true ?
					Svg(plasmoid.readConfig("media-opaque"))
				: Svg(plasmoid.readConfig("media"))

			Behavior on scale { SequentialAnimation{
					NumberAnimation { to: 0.9; duration: 150 }
					NumberAnimation { to: 1;   duration: 100 }
				}
			}

			signal clicked()

			visible: index == 2 ? showStop : true

			function update(){
				if(plasmoid.readConfig("opaqueIcons") == true)
					image = Svg(plasmoid.readConfig("media-opaque"))
				else image = Svg(plasmoid.readConfig("media"))

				contour.svgChanged()
				media.svgChanged()
			}

			Component.onCompleted: {
				mouseArea.clicked.connect(clicked)
				plasmoid.addEventListener('configChanged', update)
			}

			PlasmaCore.SvgItem{
				id: contour

				svg: image
				elementId: idContour
				smooth: true

				property int sizeExtra: (index == 1 || index == 2) ? 3 : 0

				width: buttonSize + sizeExtra
				height: buttonSize + sizeExtra

			}

			PlasmaCore.SvgItem{
				id: media

				svg: image
				elementId: idIcon
				smooth: true

				property int sizeExtra: (index == 1 || index == 2) ? 1 : 0

				width: buttonSize / 2 + sizeExtra
				height: buttonSize / 2 + sizeExtra

				anchors {
					centerIn: contour
					horizontalCenterOffset: !playing && index == 1 ? 1 : 0
				}

			}

			MouseArea{
				id: mouseArea
				anchors.fill: parent

				onPressed: parent.scale = 0.9
				onReleased: parent.scale = 1
			}
		}
	}

	Row{
		id: content
		spacing: 5
		anchors.horizontalCenter: parent.horizontalCenter

		states:[
			State{
				name: "Playing"
				when: playing
				PropertyChanges{
					target: model.itemAt(1)
					elementId: "playback-pause"
				}
			}
		]

		Repeater{
			id: model
			model: playmodel
			delegate: buttonDelegate
		}
	}
}
