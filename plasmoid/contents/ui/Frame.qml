import QtQuick 1.1

Rectangle{
	id: frame

	property string bg: theme.highlightColor
	color: bg
	radius: 1
	smooth: true

	property alias containsMouse: mouseArea.containsMouse

	Component.onCompleted:{
		mouseArea.entered.connect(entered)
		mouseArea.exited.connect(exited)
	}

	signal entered()

	signal exited()

	function fadeIn(){ fadeInAnimation.start() }

	function fadeOut(){ fadeOutAnimation.start() }

	SequentialAnimation on opacity{
		id: fadeInAnimation
		running: false
		NumberAnimation { to: 0.8 ; duration: 150 }
	}

	SequentialAnimation on opacity{
		id: fadeOutAnimation
		running: true
		NumberAnimation { to: 0.01 ; duration: 300 }
	}

	MouseArea{
		id: mouseArea

		hoverEnabled: true
		acceptedButtons: Qt.NoButton
		anchors.fill: parent
	}

}
