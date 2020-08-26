import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

import "../../js/main.js" as App
import "../components/" as Components

Page{
    id: root
    width: 1000
    height: 650

    Rectangle{
        color: App.style.light
        anchors.fill: parent
        
        Components.Navigation{
            id: navigation
            height: 50   
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
        }

        Rectangle{
            id: rectangle
            anchors.left: parent.left
            anchors.top: navigation.bottom
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
                    text: qsTr("Saturday, August 15")
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
/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:5;anchors_x:314;anchors_y:0}D{i:6;anchors_x:20;anchors_y:278}
D{i:4;anchors_height:590;anchors_width:200}D{i:9;anchors_x:306;anchors_y:48}
}
##^##*/
