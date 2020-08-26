import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Material 2.0


Rectangle {
    id: root
    width: 250
    height: 150
    radius: 10
    clip: true
    color: cardData.theme

    property var cardData: ({}) // TimeSlipWidget.qml > createschedule() > schedule;

    ToolTip{
        id: headertip
        visible: false
        text: qsTr(cardData.activity)
    }
    
    RowLayout{
        id: row_
        height: 30
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: 10
        anchors.leftMargin: 10

        Label {
            id: timelabel
            width: 46
            color: "#ffffff"
            text: qsTr(cardData.timerange.from.toTimeString())
            Layout.fillHeight: true
            Layout.fillWidth: true
            styleColor: "#ffffff"
            font.pixelSize: 11
            font.weight: Font.Light
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: title
            x: 48
            width: 94
            color: "#ffffff"
            text: qsTr(cardData.activity)
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pixelSize: 11
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
    }

    Label {
        id: description
        text: qsTr(cardData.text)
        anchors.top: row_.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: headertip.visible = true;
        onExited: headertip.visible = false;
        onClicked: dialog.open()
    }

    Dialog{
        id: dialog
        clip: true
        modal: true
        dim: true
        width: parent.width
        height: 0
        anchors.centerIn: parent
        background: TaskEditDialog{
            id: taskedit
            width: dialog.width
            theme: cardData.theme
            Material.accent: theme
            
        }

        NumberAnimation {
            id: anim
            target: dialog
            property: "height"
            duration: 200
            easing.type: Easing.InOutQuad
            from: 0
            to: 300
        }

        onOpened: {
            anim.start();
            taskedit.setdata({
                from: {
                    hour: cardData.timerange.from.getHours(),
                    minute: cardData.timerange.from.getMinutes()
                },
                to: {
                    hour: cardData.timerange.to.getHours(),
                    minute: cardData.timerange.to.getMinutes()
                },
                name: cardData.activity,
                description: cardData.text
            });
        }

        onClosed: {
            height=0;
            let data = taskedit.getdata();
            console.log(JSON.stringify(data));
        }
    }
}
