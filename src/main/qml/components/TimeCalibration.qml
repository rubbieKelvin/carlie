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
        Layout.preferredHeight: (25*hourgap)
        Layout.fillWidth: true
        

        Repeater{
            id: line_repeater
            model: timenpoint()
            delegate: Label{
                y: modelData[0]-(height/2)
                width: body.width
                color: textcolor
                text: String(modelData[1])+" hrs"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
