import QtQuick 2.9
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import "../../js/main.js" as App

Rectangle {
    id: root
    width: 300
    height: 400

    Rectangle{
        id: header
        height: 40
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top

        Label{
            x: 8
            text: "To-Do"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 18
            color: App.style.text_a
        }

        RoundButton {
            id: more
            x: 255
            y: 3
            text: "+"
            flat: true
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
        }

    }

    ScrollView{
        anchors.bottomMargin: 0
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.bottom: footer.top
        anchors.left: parent.left
        anchors.topMargin: 0

        ListView {
            id: todos
            anchors.fill: parent
            delegate: Label{
                background: Rectangle{
                    color: App.randomcolor()
                    radius: 20
                    anchors.fill: parent
                }
                text: todotext
                color: "#ffffff"
            }

            model: ListModel {
            //     ListElement {
            //         todotext: "Grey"
            //     }

            //     ListElement {
            //         todotext: "Red"
            //     }

            //     ListElement {
            //         todotext: "Blue"
            //     }

            //     ListElement {
            //         todotext: "Green"
            //     }
            }
        }

    }

    Rectangle{
        id: footer
        height: 50
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        TextField {
            id: input
            anchors.right: accept.left
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            color: App.style.text_a
            placeholderText: qsTr("what are you planning to do?..")
            background: Rectangle{
                color: App.style.light
            }
        }

        StyledButton{
            id: accept
            x: 242
            y: 1
            width: 50
            height: 50
            color: App.style.primary_a
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            useImageInsteadOfText: true
            image.source: "../../res/images/forward.svg"
        }

    }

    
}

/*##^##
Designer {
    D{i:5;anchors_height:160;anchors_width:110}D{i:14;anchors_height:51;anchors_width:241}
D{i:16;anchors_height:51;anchors_width:241;anchors_x:242;anchors_y:1}
}
##^##*/
