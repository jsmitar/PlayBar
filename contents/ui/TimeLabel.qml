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
import org.kde.plasma.components 0.1

Item{

    id: time

    //seconds
    property int topTime: 0
	//seconds
    property int currentTime: 0

    property bool negative: false

    property alias hover: mouseArea.enabled

	property int min: 0

	property int sec: 0

	property bool stopTimeAnimation: false

// 	Behavior on sec{
// 		enabled: stopTimeAnimation
// 		NumberAnimation{ duration: 50 }
// 	}

    implicitWidth: label.implicitWidth

    implicitHeight: label.implicitHeight + 4

    signal timeChanged()

    function timetoMSS(){
        var min
        var sec = currentTime/1000
        if (negative && topTime) sec = Math.abs(topTime/1000 - sec)
        min = parseInt(sec/60)
        sec = parseInt(sec - min*60)
        sec = parseInt((sec < 10 && sec > -10) ? '0'+sec : sec)
		time.min = min
		time.sec = sec
    }

	Timer{
		interval: 250
		repeat: true
		running: true
		onTriggered: timetoMSS()
	}

    Component.onCompleted: {
        timeChanged.connect(timetoMSS)
    }

	Label{
        id: label
		text: (negative ? '-' + min : min) + ':' + ( sec >= 0 && sec <= 9 ? '0'+sec : sec )
        font.weight: Font.DemiBold
        //style: Text.Sunken
		//styleColor: theme.textColor
        smooth: true
		verticalAlignment: Text.AlignVCenter

		Behavior on color{ ColorAnimation { duration: 250 } }
	}

    MouseArea{
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
		enabled: false

        onEntered: label.color = theme.highlightColor
        onExited: label.color = theme.textColor
        onReleased: {
            if (!exited || containsMouse ){
                negative = !negative
				plasmoid.writeConfig('timeNegative', negative)
                timetoMSS()
            }
        }
    }

}
