import QtQuick 1.1
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.plasma.graphicswidgets 0.1

Column{
	id: title

	height: childrenRect.height + 10

	PlasmaComponents.Label{
		id: text

		text: mpris.identity
		width: parent.width
		lineHeight: 1.2
		styleColor: theme.highlightColor
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}

	Separator{
		orientation: Qt.Horizontal
		width: parent.width
	}
}
