import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App


Rectangle {
    width: 150
    height: 150
    radius: 10
    clip: true
    color: cardData.theme

    property var cardData: {}    

    Rectangle{
        width: parent.width
        height: 30
        color: "#66000000"
        radius: 10

        Label {
            id: label
            color: "#ffffff"
            text: qsTr("Label")
            styleColor: "#ffffff"
            font.pixelSize: 11
            font.weight: Font.Light
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.right: label1.left
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.rightMargin: 0
        }

        Label {
            id: label1
            x: 48
            width: 94
            color: "#ffffff"
            text: qsTr("Title")
            font.pixelSize: 11
            font.weight: Font.Medium
            anchors.rightMargin: 8
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.top: parent.top
        }
    }
}

/*##^##
Designer {
    D{i:3;anchors_height:19;anchors_width:99;anchors_x:51;anchors_y:3}
}
##^##*/
