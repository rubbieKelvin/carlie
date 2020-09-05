import QtQuick 2.0
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import QtQuick.Controls.Material 2.0

Rectangle{
    id: root
    height: childrenRect.height

    property string label: "Today"

    Label {
        x: 8
        y: 8
        width: 624
        height: 18
        text: label
    }

    Flow {
        id: element
        x: 8
        y: 32
        width: parent.width
        height: childrenRect.height
        spacing: 5

        Repeater{
            model: 12
            delegate: Rectangle{
                color: "#ff9087"
                width: 200
                height: 150
            }
        }
    }
}
