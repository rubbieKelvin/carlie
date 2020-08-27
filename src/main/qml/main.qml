import QtQuick 2.15
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