// -*- coding: iso-8859-1 -*-
/*
 *   Author: audoban <audoban@openmailbox.org>
 *   Date: jue may 1 2014, 13:05:43
 *
 *   Code taken from PlasmaComponents.ProgressBar:
 *   Copyright 2011 Daker Fernandes Pinheiro <dakerfp@gmail.com>
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
import "plasmapackage:/code/control.js" as Control


Row{
    id: sliderSeek

    spacing: 8

	property Mpris2 source

	property bool labelVisible: true

	width: childrenRect.width

	height: childrenRect.height

    TimeLabel{
        id: lengthTime

		hover: false
        currentTime: source.length
		anchors{
			verticalCenter: slider.verticalCenter
			verticalCenterOffset: -1
		}
		visible: labelVisible
    }

	Slider{
		id: slider

		maximumValue: source.length
		value: source.position
		width: parent.width - ( labelVisible ? (lengthTime.width * 2 + spacing * 3) : spacing )
		height: 10

		onValueChanged: Control.seek(value, source.position)
		onSliderDragged: positionTime.timeChanged()

	}

	TimeLabel{
        id: positionTime

		hover: true
        topTime: source.length
        currentTime: slider.pressed ? slider.valueForPosition : source.position
		stopTimeAnimation: slider.pressed && slider.dragActive

		anchors{
			verticalCenter: slider.verticalCenter
			verticalCenterOffset: -1
		}
		visible: labelVisible
		negative: plasmoid.readConfig('timeNegative')
    }
}
