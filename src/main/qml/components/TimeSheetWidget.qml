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

    TimeCalibration{
        id: cali
        x: 0
        width: 100

        Component.onCompleted: {
            root.contentHeight = this.height;
            root.contentWidth += this.width;
        }
    }

    Repeater {
        id: sheet
        model: App.getweekdata()
        delegate: TimeSlipWidget{
            headerlabel: modelData.title
            hourlydata: modelData.data
            Component.onCompleted: {
                this.x = root.contentWidth+cali.width;
                root.contentWidth += this.width;
            }
            
        }
    }
}
