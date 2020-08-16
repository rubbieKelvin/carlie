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

    font.family: "poppins"

    StackLayout {
        anchors.fill: parent

        Pages.TimeSheet{
            width: parent.width
            height: parent.height
            
        }
    }

}