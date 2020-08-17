import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9


Rectangle {
    id: root
    width: 50
    height: 50

    property alias mouse: mouse
    property alias image: image
    property alias label: label
    property alias overlay: overlay
    property bool useImageInsteadOfText: false

    signal buttonClicked()
    signal buttonHovered(bool hovered)

    Image{
        id: image
        anchors.centerIn: parent
        visible: useImageInsteadOfText
    }

    Label{
        id: label
        visible: !useImageInsteadOfText
        anchors.centerIn: parent
    }

    Rectangle{
        id: overlay
        color: "#33000000"
        anchors.fill: parent
        visible: false
    }
    
    MouseArea {
        id: mouse
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
            overlay.visible = true;
            buttonHovered(true);
        }
        onExited: {
            overlay.visible = false;
            buttonHovered(false);
        }
        onClicked: buttonClicked()
    }
    
}
