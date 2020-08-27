import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App


ColumnLayout{
    id: root
    width: 40
    spacing: 0

    property bool headervisible: true
    property string headerlabel: "Day"
    property int hourgap: 70
    property string textcolor: App.style.text_b
    
    function timenpoint(){
        let result = [];
        for (let i=0; i<24; i++) {
            result = [...result, [i*hourgap, i]];
        }
        return result;
    }

    function labelpoint(){
        // 0 -> {hourgap} == 60minutes
        let time = new Date();
        let yhour = time.getHours()*gap;
        let ymin  = (time.getMinutes()*gap)/60;
        return yhour+ymin;
    }

    function getAbsHour(){
        let date = new Date();

        if (date.getMinutes() == 0) return date.getHours();
        return -1;
    }

    Board {
        id: header
        strokewidth: [0, 1, 0, 0]
        width: parent.width
        height: 45
        Layout.fillWidth: true
        visible: headervisible

        Label{
            text: headerlabel
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            color: App.style.text_a
        }
    }

    Board {
        id: body
        strokewidth: [0, 1, 0, 0]
        Layout.preferredHeight: (24*hourgap)
        Layout.fillWidth: true
        

        Repeater{
            id: line_repeater
            model: timenpoint()
            delegate: Label{
                y: modelData[0]-(height/2)
                width: body.width
                color: (getAbsHour()==modelData)?"red":textcolor
                text: String(modelData[1])+" hrs"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Label{
            y: labelpoint()-(height/2)
            width: body.width
            color: "#ffffff"
            text: new Date().toTimeString().slice(0, -3)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: getAbsHour() === -1
            background: Rectangle{
                color: "red"
                anchors.margins: -5
                radius: 5
            }
        }
    }
}
