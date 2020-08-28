import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

import "../../js/main.js" as App
import "../components/" as Components

Page{
    id: root
    width: 1000
    height: 650
    title: "TimeSheet"

    function reloadtimesheet() {
        timesheet.reload();
    }

    Rectangle{
        color: App.style.light
        anchors.fill: parent

        Rectangle{
            id: rectangle
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            

            Components.Board{
                id: side
                width: 300
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.top: parent.top
                strokewidth: [0, 1, 0, 0]

                Components.Calendar{
                    id: calendar
                    x: 8
                    y: 8
                    width: 284
                    height: 202
                    anchors.horizontalCenter: parent.horizontalCenter

                    onClicked:{
                        let datetime = new App.DateTime(date.toJSON());
                        timesheet.setDate(datetime);
                    }
                    
                }

                Components.TodoWidget{
                    anchors.leftMargin: 0
                    anchors.rightMargin: 1
                    anchors.top: calendar.bottom
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.topMargin: 28
                    
                }
            }

            Components.Board{
                id: toppanel
                height: 50
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: side.right
                anchors.leftMargin: 0
                strokewidth: [0, 0, 1, 0]
                color: App.style.light

                Label{
                    text: qsTr(new Date().toDateString())
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                    x: 10
                    color: App.style.text_a
                }
            }

            Components.TimeSheetWidget{
                id: timesheet
                anchors.leftMargin: 0
                anchors.top: toppanel.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: side.right
                anchors.topMargin: 0
                clip: true
                
            }
            
        }
        
    }
}