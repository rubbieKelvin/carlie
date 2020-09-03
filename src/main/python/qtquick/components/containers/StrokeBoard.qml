import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9


Rectangle {
    id: root
    width: 200
    height: 200

    
    property var strokewidth: [0, 0, 0, 0]
    property string strokecolor: "#000000"
    
    
    Rectangle {
        width: parent.width
        anchors.top: parent.top
        height: root.strokewidth[0]
        color: root.strokecolor
    }

    Rectangle {
        height: parent.height
        width: root.strokewidth[1]
        color: root.strokecolor
        anchors.right: parent.right
        
    }

    Rectangle {
        width: parent.width
        height: root.strokewidth[2]
        color: root.strokecolor
        anchors.bottom: parent.bottom
        
    }

    Rectangle {
        height: parent.height
        width: root.strokewidth[3]
        color: root.strokecolor
        anchors.left: parent.left
        
    }
    
}