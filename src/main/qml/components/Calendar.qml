import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls 2.9
import QtQuick.Layouts 1.9
import QtQuick.Controls.Styles 1.4

import "../../js/main.js" as App



Calendar{
    id: root
    dayOfWeekFormat: 1
    frameVisible: false
    navigationBarVisible: true
    weekNumbersVisible: false
    minimumDate: new Date(2000, 0, 1)

    
    function datebg(date, hovered, selected){
        if (selected){
            return App.style.primary_a;
        }else if (isCurrentDate(date)){
            return App.style.primary_b;
        }else{
            return "#f2f2f2";
        }
    }
    

    function isCurrentDate(date) {
        const current = new Date();
        return (
            current.getDay() === date.getDay() &&
            current.getDate() === date.getDate() &&
            current.getMonth() === date.getMonth() &&
            current.getYear()  === date.getYear()
        );
    }

    function calendarTitleText(date) {
        date = (date === undefined)? new Date():date;
        const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        return months[date.getMonth()]+", "+date.getFullYear();
    }

    style: CalendarStyle{
        gridVisible: false
        dayDelegate: Rectangle{
            Rectangle{
                anchors.centerIn: parent
                height: parent.height
                width: height
                color: datebg(styleData.date, styleData.hovered, styleData.selected)
                radius: isCurrentDate(styleData.date) || styleData.selected ? width/2 : 0
                visible: (isCurrentDate(styleData.date) || styleData.hovered || styleData.selected)
            }

            Label{
                text: styleData.visibleMonth ? styleData.date.getDate() : "-"
                font.pixelSize: 14
                color: (!styleData.valid) ? App.style.light : (isCurrentDate(styleData.date) || styleData.selected ? "#ffffff" : App.style.text_b)
                // font.family: "poppins"
                anchors.centerIn: parent
            }
        }

        dayOfWeekDelegate: Rectangle{
            height: 25

            Label{
                text: ["Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"][styleData.dayOfWeek]
                font.weight: (new Date().getDay() === styleData.dayOfWeek) ? Font.Bold:Font.Normal
                anchors.centerIn: parent
                font.pixelSize: 14
                color: App.style.text_a
            }
        }

        navigationBar: Rectangle{
            width: 266
            height: 36

            Label{
                x: 2
                text: qsTr("Calendar")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 18
                color: App.style.text_a
            }

            RowLayout{
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                width: parent.width*0.6
                anchors.rightMargin: 2
                

                Button{
                    text: "<"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32

                    onClicked: root.showPreviousMonth()
                }

                Label{
                    id: calendar_title
                    text: calendarTitleText(new Date(root.visibleYear, root.visibleMonth))
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Button{
                    text: ">"
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 32

                    onClicked: root.showNextMonth()
                }
            }
        }

    }
}