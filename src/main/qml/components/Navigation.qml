import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App

Rectangle {
    id: root
    width: 1000
    height:  50

    Image {
        y: 16
        width: 79
        height: 32
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        fillMode: Image.PreserveAspectFit
        source: "../../res/images/logo.svg"
    }

    ListView {
        id: navlist
        width: 159
        height: 50
        anchors.verticalCenter: parent.verticalCenter
        spacing: 20
        orientation: ListView.Horizontal
        anchors.horizontalCenter: parent.horizontalCenter
        delegate: Rectangle{
            height: 50
            width: 70

            Label{
                color: App.style.text_b
                anchors.fill: parent
                text: qsTr(name)
                font.capitalization: Font.Capitalize
                font.weight: Font.Medium
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
        model: ListModel {
            ListElement {
                name: "timesheet"
            }

            ListElement {
                name: "settings"
            }
        }
        highlight: Rectangle{
            color: "transparent"

            Rectangle{
                color: App.style.primary_c
                height: 2
                radius: 1
                anchors.bottom: parent.bottom
            }
        }
        currentIndex: 0
    }

    ColumnLayout {
        id: usernamecolumn
        height: root.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 8


        Label {
            id: username
            width: 105
            height: 18
            text: qsTr("Rubbiekelvin")
            renderType: Text.NativeRendering
            Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
            Layout.fillHeight: false
            Layout.fillWidth: true
            font.pixelSize: 12
        }

        Label {
            id: workhr
            width: 105
            height: 20
            text: qsTr("69 hrs this week")
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: false
            Layout.fillWidth: true
            font.pixelSize: 12
        }
    }

    Image {
        x: 805
        y: 8
        width: 30
        height: 30
        anchors.right: usernamecolumn.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        source: "../../res/images/avatar.png"
    }

}