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
import org.kde.plasma.components 0.1 as PlasmaComponents
import "plasmapackage:/code/control.js" as Control


Item{
    id: volumeWidget

	property Mpris2 source

	property real volume: source.volume

	property bool muted: volume == 0 ? true : false

	property alias labelVisible: label.visible

    property bool labelAbove: true

    property alias iconVisible: icon.visible

	property alias orientation: slider.orientation

	width: childrenRect.width

	height: childrenRect.height

    Flow{
        id: content

		states: [
            State{
                when: labelAbove
                PropertyChanges{
                    target: content
                    flow: Flow.TopToBottom
                    spacing: -3
                }
                PropertyChanges{
                    target: label
                    width: slider.width
                    horizontalAlignment: Text.AlignHCenter
                }
            },
            State{
                when: !labelAbove
                PropertyChanges{
                    target: content
                    flow: Flow.LeftToRight
                    spacing: 8
                }
                PropertyChanges{
                    target: label
                    width: slider.height * 1.4
                    horizontalAlignment: Text.AlignLeft
                }
            }
        ]

        PlasmaComponents.Label{
            id: label

			function setLabel(value){
				text = parseInt(value * 100)+'%'
			}

            text: parseInt(volume * 100)+'%'
            font.weight: Font.DemiBold
			width: visible ? implicitWidth : 0

			Component.onCompleted: source.volumeChanged.connect(setLabel)
        }

        Row{
            id: sliderWidget
            spacing: iconVisible ? 8 : 0

            Slider{
                id: slider

                maximumValue: if(source.source.match('vlc.*')) 1.25 ; else 1

				value: volume
				pressAndChange: true
				enabledWheel: true
				intervalDragCall: 1

                property int widthCorrection: labelAbove || !labelVisible ? 0: 43

				width: orientation == QtVertical ?
					8 : volumeWidget.width - icon.width - parent.spacing - widthCorrection
				height: orientation == QtHorizontal ?
					8 : volumeWidget.height - icon.width - parent.spacing

				onValueChanged: {
					Control.setVolume(value)
					Control.currentVolume = value
				}

				onSliderDragged: label.setLabel(valueForPosition)

				Component.onCompleted: Control.controlBarWheelEvent = (controlBarWheelEvent)
				//Component.onDestruction: Control.controlBarWheelEvent = null

            }

            IconWidget{
                id: icon

                size: visible ? 22 : 0

				anchors.verticalCenter: slider.verticalCenter
                property variant level: [
                    "audio-volume-muted", "audio-volume-low",
                    "audio-volume-medium", "audio-volume-high"
                ]

				property real volumePrev: 0

                source:
                    if (muted) level[0]
                    else if (volume <= 0.3) level[1]
                    else if (volume <= 0.6) level[2]
                    else level[3]

                onClicked: {
					if(!muted){
						volumePrev = volume
						Control.setVolume(0)
					} else Control.setVolume(volumePrev)
				}
            }
        }
    }
}
