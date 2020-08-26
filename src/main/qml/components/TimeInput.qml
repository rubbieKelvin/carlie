import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App

RowLayout {
    id: root
    width: 250
    height: 50
    clip: true

    readonly property var time: new Date()
    signal timeValueChanged

    function updatedisplaytext(){
        hour.currentIndex = time.getHours()
        minute.currentIndex = time.getMinutes()
    }

    function sethour(hr){
        time.setHours(hr);
        timeValueChanged();
    }

    function setminute(min){
        time.setMinutes(min);
        timeValueChanged();
    }

    function gettime(){
        return {
            hour: time.getHours(),
            minute: time.getMinutes()
        }
    }

    ComboBox {
        id: hour
        x: 8
        y: 33
        width: 65
        height: 48
        Layout.fillWidth: true
        model: 24
        onCurrentValueChanged: sethour(currentValue)
    }

    ComboBox {
        id: minute
        x: 84
        y: 34
        width: 65
        height: 48
        Layout.fillWidth: true
        model: 60
        onCurrentValueChanged: setminute(currentValue)
    }
}
