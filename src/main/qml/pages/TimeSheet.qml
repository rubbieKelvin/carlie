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
            height: 60         
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
        }

        Rectangle{
            id: rectangle
            anchors.topMargin: 60
            anchors.fill: parent

            Components.Board{
                id: side
                width: 300
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.top: parent.top
                strokewidth: [0, 1, 0, 0]
            }

            Components.Board{
                id: toppanel
                height: 60
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: side.right
                anchors.leftMargin: 0
                strokewidth: [0, 0, 1, 0]
                color: App.style.light
            }
            
        }
        
    }
}
/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:4;anchors_height:590;anchors_width:200}D{i:5;anchors_x:314;anchors_y:0}
}
##^##*/
