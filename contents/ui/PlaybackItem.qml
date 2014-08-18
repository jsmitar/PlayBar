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
import "plasmapackage:/code/control.js" as Control

Item{
    id: playbackitem

    property bool playing: source.playbackStatus == 'Playing'

    property bool showStop: plasmoid.readConfig('showStop')

    property bool vertical: false

    property real spacing: -2

    property int buttonSize: 22

	property Mpris2 source

    signal playPause()

    signal previous()

    signal next()

    signal stop()

	function showStopChanged(source){
		if( source == undefined ) source = playbackitem.source.source
		if( source != 'spotify' ) showStop = plasmoid.readConfig('showStop')
		else showStop = false
	}

    onPlayPause: {
		if(source.source == 'spotify' ) {
			Control.startOperation('PlayPause')
			return
		}
		if(!playing) Control.startOperation('Play')
		else Control.startOperation('PlayPause')
	}

    onPrevious: Control.startOperation('Previous')

    onNext: Control.startOperation('Next')

    onStop: if(source.playbackStatus != "Stopped") Control.startOperation('Stop')

	Component.onCompleted: {
		source.sourceChanged.connect(showStopChanged)
		plasmoid.addEventListener('configChanged', showStopChanged)
	}

	Component.onDestruction: {
		source.sourceChanged.disconnect(showStopChanged)
	}
}
