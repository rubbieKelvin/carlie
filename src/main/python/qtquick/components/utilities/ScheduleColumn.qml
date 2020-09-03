import QtQuick 2.0
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

import "../containers/" as UiContainer
import "../../javascript/style.js" as Ui

UiContainer.StrokeBoard {
    id: strokeBoard
    width: 160
    height: childrenRect.height < minimumHeight ? minimumHeight : childrenRect.height
    color: Ui.color("BG", theme)
    strokewidth: [0, 1, 0, 0]
    strokecolor: Ui.color("Gray4", theme)


    property string title: "Title"
    property string theme: Ui.Theme.Light
    property var scheduleModel: 20
    property int minimumHeight: 500

    UiContainer.StrokeBoard {
        id: header
        width: parent.width
        height: 35
        strokewidth: [1, 1, 1, 0]
        color: Ui.color("BG", theme)
        strokecolor: Ui.color("Gray4", theme)

        Label{
            text: title
            clip: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pointSize: 12
        }
    }

    ColumnLayout{
        width: parent.width
        spacing: 0
        anchors.top: header.bottom
        anchors.topMargin: 0
        
        Repeater{
            id: repeater
            model: scheduleModel

            delegate: ScheduleCard{
                Layout.margins: 5
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillWidth: true
            }
        }
    }
}
