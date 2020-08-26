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
    property int gap: 100
    property var weekdates: getweek();

    signal weekChanged();

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

    function setDate(date){
        this.selecteddate = date;
        this.weekdates = getweek();
        weekChanged();
    }

    TimeCalibration{
        id: cali
        x: 0
        width: 100
        headerlabel: "Hours"
        hourgap: gap

        Component.onCompleted: {
            root.contentHeight = this.height;
            root.contentWidth += this.width;
        }
    }

    Repeater {
        id: sheet
        model: 7
        delegate: TimeSlipWidget{
            id: aslip
            datetime: root.weekdates[modelData]
            timeline: App.scheduler.gettodos(datetime, [])
            hourgap: gap

            Component.onCompleted: {
                this.x = root.contentWidth+cali.width;
                root.contentWidth += this.width;
            }

            onPinned: {
                if (App.scheduler.newtodo(datetime, carlie.generateuuid()) !== null){
                    datetime = weekdates[modelData];
                    timeline = App.scheduler.gettodos(datetime, []);

                }else{
                    // there was an error creating task
                }
            }

            
            Connections {
                target: root
                
                function onWeekChanged(){
                    aslip.timeline = App.scheduler.gettodos(aslip.datetime, []);
                }
            }
            

            onTaskEdited: {
                App.scheduler.edittodo(id, datetime, newdata);
                this.datetime = weekdates[modelData];
                this.timeline = App.scheduler.gettodos(this.datetime, []);
            }
            
        }
    }
}
