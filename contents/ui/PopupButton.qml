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

IconWidget{
	id: iconPopup

	property variant icons: [ "go-up", "go-down", "go-next", "go-previous" ]

	property string opened: icons[0]

	property string closed: icons[1]

	Component.onCompleted:{
		function locationChanged(){

			switch(plasmoid.location){
				case Floating:
				case Desktop:
				case TopEdge:
					opened = icons[0]
					closed = icons[1]
					break
				case BottomEdge:
					opened = icons[1]
					closed = icons[0]
					break
				case LeftEdge:
					opened = icons[3]
					closed = icons[2]
					break
				case RightEdge:
					opened = icons[2]
					closed = icons[3]
			}
		}

		plasmoid.locationChanged.connect(locationChanged)
		locationChanged()
	}
}
