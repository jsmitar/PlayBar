.pragma library

var source
var serv
var identity
var icon

var currentVolume = 0

function setSource(sourceName, identity){
	if(sourceName == source) return

	source = sourceName
	serv = service("mpris2", sourceName)
	if(sourceName != '@multiplex') setActions(sourceName, identity)
	else removeActions()
}

function seek(position, currentPosition){
	if(source == 'clementine') {
		seekRelative(position, currentPosition)
		return
	}

	job = serv.operationDescription('SetPosition')
	job['microseconds'] = (position * 1000).toFixed(0)
	serv.startOperationCall(job)
}

function seekRelative(position, currentPosition){
	job = serv.operationDescription('Seek')
	job['microseconds'] = ((-currentPosition + position) * 1000).toFixed(0)
	serv.startOperationCall(job)
}

function startOperation(name){
	job = serv.operationDescription(name)
	serv.startOperationCall(job)
}

function setVolume(value){
	job = serv.operationDescription('SetVolume')
	job['level'] = value
	serv.startOperationCall(job)
}

function setActions(sourceName, identity){

	if(sourceName.match('vlc')){
		icon = 'vlc'
	}else{
		icon = sourceName
	}

	switch(sourceName){
		case 'spotify':
			icon = 'spotify-client'
			break
	}

	plasmoid.setAction('raise', i18nc("@action:inmenu", "Open %1", identity), icon)
	plasmoid.setAction('quit', i18nc("@action:inmenu", "Quit"), 'exit')
	plasmoid.setActionSeparator('sep0')
	plasmoid.setAction('nextSource', i18nc("@action:inmenu", "Next source"), 'go-next')
	plasmoid.setActionSeparator('sep1')

}

function removeActions(){
	plasmoid.removeAction('raise')
	plasmoid.removeAction('quit')
	plasmoid.removeAction('sep0')
	plasmoid.removeAction('nextSource')
	plasmoid.removeAction('sep1')
}

print("addons: " + plasmoid.listAddons("org.kde.plasma.javascript-addons-example")[0].id)

function controlBarWheelEvent(wheel){}

function sourceNotify(){}

function controlBarWheelNotify(){}


