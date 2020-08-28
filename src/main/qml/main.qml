import QtQuick 2.15
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

import "../js/main.js" as App
import "pages/" as Pages
import "components/" as Components

ApplicationWindow{
    id: window
    visible: true
    width: 1000
    height: 650

    font.family: "poppins"

    Components.Navigation{
        id: navigation
        height: 50   
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        pages: [tspage]
    }

    StackLayout {
        id: pagestack        
        anchors.left: parent.left
        anchors.top: navigation.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        

        Pages.TimeSheet{
            id: tspage
            width: parent.width
            height: parent.height
        }
    }

    Component.onCompleted: {
        App.scheduler.carlie = carlie;
        App.scheduler.data = JSON.parse(carlie.getData());
        tspage.reloadtimesheet()
    }
}