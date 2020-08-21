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

    function pointtotime(y){
        let date = datetime.copy();
        date.setHours(0);
        date.setSeconds(0);
        date.setMinutes(Math.floor((60*y)/hourgap))
        return date
    }

    function timetoypoint(time){
        // 0 -> {hourgap} == 60minutes
        let yhour = time.getHours()*hourgap;
        let ymin  = (time.getMinutes()*hourgap)/60;
        return yhour+ymin;
    }

    function timetoheight(from, to){
        let start = timetoypoint(from);
        let stop  = timetoypoint(to);

        return stop - start;
    }

    function createschedule(y){
        let date = pointtotime(y);
        let schedule = {
            timerange: new App.DateRange(date, date.copy()),
            activity: "New Task",
            text: "",
            theme: App.randomcolor()
        };
        schedule.timerange.to.setMinutes(schedule.timerange.to.getMinutes()+30);

        if (!schedule.timerange.elapseAnyByTime(hourlydata.map(
            (e) => e.timerange
        ))) hourlydata.push(schedule);
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
        Layout.preferredHeight: (24*hourgap)
        Layout.fillHeight: true
        Layout.fillWidth: true

        ToolTip{
            id: sheettip
            visible: false
            text: pointtotime(sheetmouse.mouseY).toLocaleTimeString()
            delay: 500
        }
        
        MouseArea {
            id: sheetmouse
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: {sheettip.visible=true}
            onExited: {sheettip.visible=false}
            onClicked: {
                createschedule(mouseY)
                card_repeater.model = hourlydata
            }
        }
        

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
                y: timetoypoint(modelData.timerange.from)
                height: timetoheight(modelData.timerange.from, modelData.timerange.to)
                cardData: modelData
            }
        }
    }
}
