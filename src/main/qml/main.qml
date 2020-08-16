import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

import "../js/main.js" as App
import "pages/" as Pages

ApplicationWindow{
    id: window
    visible: true
    width: 1000
    height: 650

    StackLayout {
        anchors.fill: parent

        Pages.TimeSheet{
            width: parent.width
            height: parent.height
            
        }
    }

}

/*##^##
Designer {
    D{i:0;annotation:"1 //;;// Carlie //;;// rubbie kelvin //;;//  //;;// 1597536927";customId:"7caf5ffe-2ab8-4f59-835d-5463e352a606";formeditorZoom:0.5}
D{i:1}D{i:3;anchors_height:100;anchors_width:100;anchors_x:200;anchors_y:174}
}
##^##*/
