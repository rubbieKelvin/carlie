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
        anchors.fill: parent
        color: "#ffffff"
        
        Components.Navigation{
            height: 70            
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            
        }
        
    }
}