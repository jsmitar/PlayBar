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
import org.kde.plasma.core 0.1
import "plasmapackage:/code/control.js" as Control

DataSource{
	id: dataSource

	engine: 'mpris2'

	interval: minimumLoad


	property int maximumLoad: 500

	property int minimumLoad: 1500

	property bool initialConnection: true


	property string previousSource

	property string source: connectedSources[0] != undefined ? connectedSources[0] : ""

	property bool sourceActive: hasSource('CanControl') ? data[source]['CanControl'] : false


	property string identity: hasSource('Identity') ? data[source]['Identity'] : "No source"

	property string playbackStatus: hasSource('PlaybackStatus') ? data[source]['PlaybackStatus'] : "unknown"

	property string artUrl: hasMetadata('artUrl') ? data[source]['Metadata']['mpris:artUrl'] : ""

	property string artist: hasMetadata('artist') ? data[source]['Metadata']['xesam:artist'].toString() : ""

	property string album: hasMetadata('album') ? data[source]['Metadata']['xesam:album'] : ""

	property string title: hasMetadata('title') ? data[source]['Metadata']['xesam:title'] : ""

	property int length: hasMetadata('length') ? data[source]['Metadata']['mpris:length'] / 1000: 0

	property int position: 0

	property real userRating: 0

	property real volume: hasSource('Volume') ? data[source]['Volume'] : 0


	signal sourceChanged(string source)

	signal ratingChanged()

	signal volumeChanged(real value)

	onSourceChanged: {
		if(data[source] != undefined ) identity = data[source]['Identity']
		else identity = "No source"
	}

	Component.onCompleted: initialConnection = true


	function hasMetadata(key){
		if (interval == minimumLoad) return false

		if (key == 'artUrl' || key == 'length') key = 'mpris:'+key
		else key = 'xesam:'+key

		return data[source] != undefined
			&& data[source]['Metadata'] != undefined
			&& data[source]['Metadata'][key] != undefined
	}

	function hasSource(key){
		return data[source] != undefined
			&& data[source][key] != undefined
	}

	function connect(source){
		connectedSources = [source]
		Control.setSource(source)
	}

	function nextSource(){
		for(i = 0; i < sources.length; i++){
			if(source == sources[i]){
				if( ++i >= sources.length ){
					if( sources[0] == '@multiplex' )
						connect(sources[1])
					else connect(sources[0])
				}else if( sources[i] != '@multiplex' )
					connect(sources[i])
				else
					connect(sources[0])
				return
			}
		}
	}

	onNewData: {

		if(interval == maximumLoad)
			position = data['Position'] /1000

		if(hasMetadata('userRating') && data['Metadata']['xesam:userRating'] != userRating ){
			userRating = data['Metadata']['xesam:userRating'] != undefined ?
						 data['Metadata']['xesam:userRating'] : 0
			ratingChanged()
		}

		if(hasSource('Volume')) volumeChanged(data['Volume'])

	}

	onSourceAdded: {
		if(initialConnection && connectedSources[0] != source && source != '@multiplex') {
			print("sourceAdded?: "+source)
			previousSource = connectedSources[0] == undefined ? "" : connectedSources[0]
			connectedSources = [source]
			initialConnection = false
		}
	}

	onSourceRemoved: {
		connectedSources = [sources[0]]
		initialConnection = true
	}

	onSourceConnected: {
		if(source != previousSource) {
			print("connected: "+source)
			previousSource = source
			sourceChanged(source)
		}
		idty = data[source] != undefined ? data[source]['Identity'] : "No source"
		Control.setSource(source, idty)
	}

	onSourceDisconnected: {
		print("disconnected: "+source)
	}

	//onIntervalChanged: print("interval: "+interval)
}
