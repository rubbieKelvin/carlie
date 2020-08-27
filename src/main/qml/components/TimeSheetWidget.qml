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

    function linerpoint(){
        // 0 -> {hourgap} == 60minutes
        let time = new Date();
        let yhour = time.getHours()*gap;
        let ymin  = (time.getMinutes()*gap)/60;
        return yhour+ymin+45; // 45 is the header height of all time slip; this would have to be manually updated
    }

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

    function reload() {
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
                    aslip.datetime = weekdates[modelData];
                    aslip.timeline = App.scheduler.gettodos(aslip.datetime, []);
                }
            }
            

            onTaskEdited: {
                let result = App.scheduler.edittodo(id, datetime, newdata);
                let errormsg = ""

                if (result===null) errormsg = "could not find todo!";
                else if(!result) errormsg = "task overlapse!";

                datetime = weekdates[modelData];
                timeline = App.scheduler.gettodos(datetime, []);
            }

            onDeleteRequest: {
                App.scheduler.deleteTodo(id, datetime);
                datetime = weekdates[modelData];
                timeline = App.scheduler.gettodos(datetime, []);
            }
            
        }
    }

    Rectangle {
        id: liner
        width: root.contentWidth
        height: 1
        color: "#33ff0000"
        y: linerpoint()
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}
}
##^##*/
