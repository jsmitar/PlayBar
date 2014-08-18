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
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets


Item{
	id: layout

	property Mpris2 mpris

	property bool isSpotify: mpris.source == 'spotify'

	property bool noSource:
		mpris.connectedSources ==  ""

	property variant idLayout: undefined

	property variant layouts: [ defaultLayout, minimalLayout ]

	height: childrenRect.height
	width: childrenRect.width

	signal layoutChanged()

	Component.onCompleted: {
		plasmoid.addEventListener('configChanged', function(){
				idLayout = layouts[plasmoid.readConfig('PlayBarLayout')]
			}
		)
	}

	Loader{
		id: loader

		sourceComponent: if(noSource) undefined
			else if(isSpotify) minimalLayout
			else idLayout

		onLoaded:{
			layoutChanged()
		}
	}

	Component{
		id: minimalLayout

		Item{
			height: cover.height + 4
			width: 350

			Component.onCompleted: {
				cover.source = layout.mpris
				info.source = layout.mpris
				playback.source = layout.mpris
				volume.source = layout.mpris
			}

			CoverArt{
				id: cover

				anchors{
					rightMargin: 8
					leftMargin: 4
					verticalCenter: parent.verticalCenter
				}
			}
			PlasmaWidgets.Separator{
				id: separator

				orientation: Qt.Vertical
				anchors{
					left: cover.right
					top: cover.top
					bottom: cover.bottom
					topMargin: 4
					bottomMargin: 4
					leftMargin: 8
					rightMargin: 8
				}
			}
			TrackInfo{
				id: info

				anchors{
					leftMargin: 8
					rightMargin: volume.visible ? 10 : 4
					left: separator.right
					right: volume.visible ? volume.left : parent.right
					top: parent.top
					bottom: playback.top
				}
			}
			PlaybackWidget{
				id: playback

				showStop: isSpotify ? false : plasmoid.readConfig('showStop')

				spacing: 8

				anchors{
					bottom: parent.bottom
					topMargin: 4
					horizontalCenter: parent.horizontalCenter
					horizontalCenterOffset: cover.width / 2 - (isSpotify ? 0 : 8)
				}
			}
			Volume{
				id: volume

				iconVisible: false
				labelVisible: false
				orientation: QtVertical

				visible: !isSpotify

				width: 16
				height: cover.height - 8

				anchors{
 					verticalCenter: cover.verticalCenter
					verticalCenterOffset: 1
					//top: cover.top
					//bottom: cover.bottom
 					right: parent.right
					//rightMargin: 4
				}
			}
		}
	}

	Component{
		id: defaultLayout

		Item{
			height: cover.height + 4
			width: 500

			Component.onCompleted: {
				cover.source = layout.mpris
				playback.source = layout.mpris
				rating.source = layout.mpris
				info.source = layout.mpris
				volume.source = layout.mpris
				seek.source = layout.mpris
			}

			CoverArt{
				id: cover

				anchors{
					rightMargin: 8
					leftMargin: 4
					verticalCenter: parent.verticalCenter
				}
			}
			PlaybackWidget{
				id: playback

				anchors{
					leftMargin: 8
					rightMargin: 8
					topMargin: 2
					top: parent.top
					left: cover.right
				}
			}
			RatingItem{
				id: rating

				anchors{
					topMargin: 10
					horizontalCenter: playback.horizontalCenter
					top: playback.bottom
					bottom: seek.top
				}
			}
			PlasmaWidgets.Separator{
				id: separator

				orientation: Qt.Vertical
				anchors{
					margins: 8
					top: parent.top
					bottom: seek.top
					left: playback.right
				}
			}
			TrackInfo{
				id: info

				widthLabelArtist: width - volume.width - 12
				widthLabelAlbum:  width - volume.width - 12

				anchors{
					leftMargin: 8
					rightMargin: 4
					left: separator.right
					right: parent.right
					top: parent.top
				}
			}
			Volume{
				id: volume

				width: 120
				anchors{
					rightMargin: 4
					leftMargin: 8
					bottomMargin: 4
					bottom: seek.top
					right: info.right
				}
			}
			SliderSeek{
				id: seek

				width: parent.width - cover.width - 16
				anchors{
					leftMargin: 10
					left: cover.right
					bottom: cover.bottom
					bottomMargin: -4
				}
			}
		}
	}

}
