import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App


Rectangle {
    id: root
    width: 200
    height: 200

    
    property var strokewidth: [0, 0, 0, 0]
    property string strokecolor: "#E4DBE5"
    
    
    Rectangle {
        id: stroke_top
        width: parent.width
        anchors.top: parent.top
        height: root.strokewidth[0]
        color: root.strokecolor
    }

    Rectangle {
        id: stroke_right
        height: parent.height
        width: root.strokewidth[1]
        color: root.strokecolor
        anchors.right: parent.right
        
    }

    Rectangle {
        id: stroke_bottom
        width: parent.width
        height: root.strokewidth[2]
        color: root.strokecolor
        anchors.bottom: parent.bottom
        
    }

    Rectangle {
        id: stroke_left
        height: parent.height
        width: root.strokewidth[3]
        color: root.strokecolor
        anchors.left: parent.left
        
    }
    
}
