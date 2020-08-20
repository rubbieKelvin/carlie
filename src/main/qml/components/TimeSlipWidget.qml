import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App

ColumnLayout{
    id: root
    width: 200
    spacing: 0

    property int hourgap: 70
    property string linecolor: "#e2e2e2"
    property int padding: 20
    property bool headervisible: true
    property var hourlydata: []
    property var datetime: new App.DateTime()
    property string headerlabel: datetime.dayString(true)

    function ypoints(){
        let result = [];
        for (let i=0; i<24; i++) {
            result = [...result, i*hourgap];
        }
        return result;
    }

    function timetoypoint(time){
        // 0 -> {hourgap} == 60minutes
        let yhour = time.getHours()*hourgap;
        let ymin  = (time.getMinutes()*hourgap)/60;
        return yhour+ymin;
    }

    function timetowidth(from, to){
        let start = timetoypoint(from);
        let stop  = timetoypoint(to);

        return stop - start;
    }
    
    Board {
        id: header
        width: parent.width
        height: 45
        Layout.fillWidth: true
        visible: headervisible
        strokewidth: [0, 1, 0, 0]

        ToolTip{
            id: headertip
            visible: false
            text: qsTr(datetime.toDateString())
        }
        
        Label{
            text: headerlabel
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            color: App.style.text_a
        }
        
        MouseArea {
            id: headermouse
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {headertip.visible = true}
            onExited: {headertip.visible = false}
            onClicked: {}
        }
        
    }
    

    Board {
        id: body
        strokewidth: [0, 1, 0, 0]
        Layout.preferredHeight: (25*hourgap)
        Layout.fillHeight: true
        Layout.fillWidth: true


        Repeater{
            id: line_repeater
            model: ypoints()
            delegate: Rectangle{
                y: modelData
                width: body.width
                height: 1
                color: linecolor
            }
        }

        Repeater{
            id: card_repeater
            model: hourlydata
            delegate: TimeCard{
                width: body.width-padding
                anchors.horizontalCenter: parent.horizontalCenter
                y: timetoypoint(modelData.from)
                height: timetowidth(modelData.from, modelData.to)+30
            }
        }
    }
}
