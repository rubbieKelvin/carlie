import QtQuick 2.0
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9

Rectangle {
    width: 250
    height: 100
    radius: 8
    color: "lightblue"
    id: root

    Label {
        id: label
        text: qsTr("<b>Title</b><p>Hellow</p>")
        font.pointSize: 12
        anchors.fill: parent
        anchors.margins: 4
    }
}