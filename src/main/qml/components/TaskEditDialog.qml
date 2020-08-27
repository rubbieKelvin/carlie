import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import QtQuick.Controls.Material 2.0
import "../../js/main.js" as App

Rectangle {
    id: root
    width: 350
    height: 400

    property string theme
    signal finished
    signal deleted

    function setdata(data) {
        timefrom.sethour(data.from.hour);
        timefrom.setminute(data.from.minute);
        timefrom.updatedisplaytext();

        timeto.sethour(data.to.hour);
        timeto.setminute(data.to.minute);
        timeto.updatedisplaytext();

        activityname.text = data.name;

        description.text = data.description;
    }

    function getdata() {
        return {
            from: {
                hour: timefrom.time.getHours(),
                minute: timefrom.time.getMinutes()
            },
            to: {
                hour: timeto.time.getHours(),
                minute: timeto.time.getMinutes()
            },
            name: activityname.text,
            description: description.text
        }
    }

    Rectangle {
        id: header
        height: 58
        color: theme
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top

        RowLayout {
            id: rowLayout
            anchors.rightMargin: 8
            anchors.leftMargin: 8
            anchors.bottomMargin: 8
            anchors.topMargin: 8
            anchors.fill: parent

            TextField {
                id: activityname
                color: "#ffffff"
                text: qsTr("Label")
                font.pixelSize: 12
                placeholderText: "Title..."
                verticalAlignment: Text.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.accent: "#44ffffff"
                background: Rectangle{
                    color: "transparent"
                }

                onAccepted: finished()
            }

            RoundButton {
                id: roundButton
                width: 40
                height: 40
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                icon.source: "../../res/images/trash-empty.png"
                flat: true
                onClicked: deleted()
            }
        }
    }

    ColumnLayout {
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0

        ColumnLayout{
            width: 308
            height: 71
            Layout.fillWidth: true
            
            Label {
                id: label
                x: 8
                y: 85
                text: qsTr("From")
                font.pixelSize: 12
            }

            TimeInput {
                id: timefrom
                x: 0
                y: 0
                width: 324
                height: 50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true

                onTimeValueChanged: {

                }
            }

        }

        ColumnLayout {
            width: 308
            height: 71
            Layout.fillWidth: true

            Label {
                id: label1
                x: 8
                y: 85
                text: qsTr("To")
                font.pixelSize: 12
            }

            TimeInput {
                id: timeto
                x: 0
                y: 0
                width: 324
                height: 50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: false
            }
        }

        TextArea {
            id: description
            width: 310
            height: 148
            textFormat: Text.RichText
            font.pixelSize: 12
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            Layout.fillHeight: true
            Layout.fillWidth: true
            placeholderText: qsTr("Description")
        }
    }
}

/*##^##
Designer {
    D{i:2;anchors_height:100;anchors_width:100}D{i:1;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0}
D{i:9;anchors_height:71;anchors_width:308;anchors_x:30;anchors_y:95}D{i:7;anchors_height:71;anchors_width:308;anchors_x:30;anchors_y:95}
D{i:10;anchors_height:71;anchors_width:308;anchors_x:30;anchors_y:95}D{i:6;anchors_height:100;anchors_width:100;anchors_x:30;anchors_y:95}
}
##^##*/
