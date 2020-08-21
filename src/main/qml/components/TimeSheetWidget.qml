import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App

ScrollView {
    id: root
    width: 600
    height: 600
    contentHeight: 0
    contentWidth: 0
    clip: true

    property var selecteddate: new App.DateTime();
    readonly property var weekdates: getweek(); 
    

    function getweek(){
        let result = [
            selecteddate.copy(),
            selecteddate.copy(),
            selecteddate.copy(),
            selecteddate.copy(),
            selecteddate.copy(),
            selecteddate.copy(),
            selecteddate.copy()
        ];

        let pw = selecteddate.getDay();

        for (let i=0; i<result.length; i++) {
            const element = result[i];
            element.setDate(selecteddate.getDate()-(pw-i));
        }

        return result;
    }

    TimeCalibration{
        id: cali
        x: 0
        width: 100
        headerlabel: "Hours"

        Component.onCompleted: {
            root.contentHeight = this.height;
            root.contentWidth += this.width;
        }
    }

    Repeater {
        id: sheet
        model: 7
        delegate: TimeSlipWidget{
            datetime: weekdates[modelData]
            Component.onCompleted: {
                this.x = root.contentWidth+cali.width;
                root.contentWidth += this.width;
            }
            
        }
    }
}
