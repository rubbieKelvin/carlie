import QtQuick 2.0
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import QtQuick.Controls.Material 2.0

import "../javascript/style.js" as Ui
import "../components/utilities" as UiUtils
import "../components/containers" as UiContainers

Page{
    id: root
    title: "Schedule"
    
    property string theme: Ui.Theme.Light

    Rectangle {
        id: header
        height: 30
        // color: Ui.color("BG", theme)
        anchors.right: right_side.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Label {
            x: 20
            y: 8
            text: qsTr("This Week, September")
            font.weight: Font.Light
            font.pointSize: 12
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    ScrollView{
        y: 1
        anchors.rightMargin: 0
        clip: true
        anchors.top: header.bottom
        anchors.right: right_side.left
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0

        ListView {
            model:7
            anchors.fill: parent
            delegate: UiContainers.ScheduleBoard{
                width: root.width
            }
        }

    }

    Rectangle {
        id: right_side
        x: 361
        width: 400
        color: "#ffffff"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
    }

    
    Component.onCompleted: print(width)
    

}