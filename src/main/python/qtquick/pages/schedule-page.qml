import QtQuick 2.0
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

import "../javascript/style.js" as Ui
import "../components/containers" as UiContainers
import "../components/utilities" as UiUtils

Page{
    id: root
    title: "Schedule"
    
    property string theme: Ui.Theme.Light

    Rectangle {
        id: header
        width: parent.width
        height: 30
        color: Ui.color("BG", theme)

        Label {
            id: label
            x: 20
            y: 8
            text: qsTr("This Week, September")
            font.weight: Font.Light
            font.pointSize: 12
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    ScrollView{
        id: srl_
        y: 1
        clip: true
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
    }

}