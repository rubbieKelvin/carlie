import QtQuick 2.0
import QtQuick.Controls 2.9

Rectangle {
    id: root
    width: 40
    height: 40
    radius: 8

    property alias mouse: mouse
    property alias icon: icon
    property string title: ""
    property bool hovered: false

    signal buttonClicked

    ToolTip{
        visible: title !== "" && root.hovered
        text: title
        delay: 1000
    }

    Image {
        id: icon
        width: 25
        height: 25
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle{
        id: overlay
        color: "#1f000000"
        anchors.fill: parent
        visible: mouse.hoverEnabled && hovered
        radius: root.radius
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: hovered = true
        onExited: hovered = false
        onClicked: buttonClicked()
    }
}
