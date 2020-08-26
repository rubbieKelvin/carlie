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

    signal edited(var payload);

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
        color: "#ffffff"
        text: qsTr(cardData.text)
        textFormat: Text.RichText
        wrapMode: Text.WordWrap
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.top: row_.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 5
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
            
            // validate time: check if from < to;
            let from = new App.DateTime(); 
            let to   = new App.DateTime();

            from.setHours(data.from.hour);
            from.setMinutes(data.from.minute);

            to.setHours(data.to.hour);
            to.setMinutes(data.to.minute);

            if (App.mintime(from, to) === from){


                // time range
                let prevtimerange = cardData.timerange;
                
                let timerangefrom = new App.DateTime(cardData.timerange.from.toJSON());
                timerangefrom.setHours(data.from.hour);
                timerangefrom.setMinutes(data.from.minute);
                
                let timerangeto = new App.DateTime(cardData.timerange.to.toJSON());
                timerangeto.setHours(data.to.hour);
                timerangeto.setMinutes(data.to.minute);

                // check if it overlaps
                edited({
                    timerange: new App.DateRange(timerangefrom, timerangeto),
                    activity: data.name,
                    text: data.description,
                });

                // update
                headertip.text = root.cardData.activity;
            }else{
                errdialog.title = "Error";
                errdialoglabel.text = "starting time should be less than ending time!";
                errdialog.open();
            }
        }
    }

    Dialog{
        id: errdialog
        clip: true
        dim: true
        width: 300
        height: 180
        standardButtons: Dialog.Ok

        Label{
            id: errdialoglabel
            wrapMode: Text.WordWrap
            anchors.fill: parent
        }
    }
}
