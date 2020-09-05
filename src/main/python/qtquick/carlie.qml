// QtQuick
import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Layouts 1.9
import QtQuick.Controls 2.9
import QtGraphicalEffects 1.12
import QtQuick.Controls.Material 2.0

// Javascript & qml
import "./pages/" as UiPages
import "./javascript/style.js" as Ui
import "./components/buttons" as UiButtons

// Python Plugins
import Carlie.Plugins 1.0

// application window
Window{
    id: root
    visible: true
    width: 1000
    height: 650

    // properties
    property var theme: "Light"

    // material bindings
    Material.accent: Ui.color("Blue", theme)
    Material.theme: (theme === Ui.Theme.Light) ? Material.Light : Material.Dark

    
    Component.onCompleted: {
        theme = JSON.parse(storage.getSetting("theme"));
    }
    
    Rectangle {
        anchors.left: sidebar.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 0
        color: Ui.color("BG", theme)

        Label {
            x: 21
            y: 16
            width: 174
            height: 19
            text: stack.children[stack.currentIndex].title
        }

        StackLayout {
            id: stack
            anchors.topMargin: 64
            anchors.fill: parent

            UiPages.Schedule{
                theme: theme
                width: parent.width
                height: parent.height

                
                Component.onCompleted: print(stack.width)
                
            }
        }
    }

    Rectangle {
        id: sidebar
        width: 60
        height: parent.height
        color: Ui.color("Gray6", theme)
        layer.enabled: true
        layer.effect: DropShadow {
            color: "#34000000"
            radius: 8
            samples: 17
            spread: 0
            transparentBorder: true
            horizontalOffset: 1
            verticalOffset: 0
        }

        UiButtons.IconButton{
            id: logo
            x: 10
            y: 16
            color: Ui.color("Blue", theme)
            anchors.horizontalCenter: parent.horizontalCenter
            mouse.cursorShape: Qt.ArrowCursor
            mouse.hoverEnabled: false

            UiSvg{
                source: "qtquick/icons/coffee.svg"
                onSourceChanged: logo.icon.source = sourceData;
                Component.onCompleted: {
                    setAttr("path", "fill", "#ffffff")
                }
            }
        }

        ColumnLayout {
            x: 8
            y: 87
            width: 44
            height: 184
            anchors.horizontalCenterOffset: 0
            spacing: 2.7
            anchors.horizontalCenter: parent.horizontalCenter

            UiButtons.IconButton{
                id: schedule_btn
                title: qsTr("Schedule")
                color: Ui.color("Gray6", theme)
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                onButtonClicked: {
                    stack.push("pages/schedule-page.qml");
                    
                    schedule_btn_sr.setAttr("path", "fill", Ui.color("Blue", theme))
                    search_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    note_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    setting_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                }

                UiSvg{
                    id: schedule_btn_sr
                    source: "qtquick/icons/calendar-today.svg"
                    onSourceChanged: schedule_btn.icon.source = sourceData;
                    Component.onCompleted: {
                        setAttr("path", "fill", Ui.color("Blue", theme))
                    }
                }
            }

            UiButtons.IconButton{
                id: search_btn
                title: qsTr("Search")
                color: Ui.color("Gray6", theme)
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            
                onButtonClicked: {
                    stack.push("pages/search-page.qml");

                    schedule_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    search_btn_sr.setAttr("path", "fill", Ui.color("Blue", theme))
                    note_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    setting_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                }

                UiSvg{
                    id: search_btn_sr
                    source: "qtquick/icons/search.svg"
                    onSourceChanged: search_btn.icon.source = sourceData;
                    Component.onCompleted: {
                        setAttr("path", "fill", Ui.color("Text", theme))
                    }
                }
            }

            UiButtons.IconButton{
                id: note_btn
                title: qsTr("Notes")
                color: Ui.color("Gray6", theme)
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            
                onButtonClicked: {
                    stack.push("pages/notes-page.qml");

                    schedule_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    search_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    note_btn_sr.setAttr("path", "fill", Ui.color("Blue", theme))
                    setting_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                }

                UiSvg{
                    id: note_btn_sr
                    source: "qtquick/icons/notes.svg"
                    onSourceChanged: note_btn.icon.source = sourceData;
                    Component.onCompleted: {
                        setAttr("path", "fill", Ui.color("Text", theme))
                    }
                }
            }

            UiButtons.IconButton{
                id: setting_btn
                title: qsTr("Settings")
                color: Ui.color("Gray6", theme)
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            
                onButtonClicked: {
                    stack.push("pages/settings-page.qml");

                    schedule_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    search_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    note_btn_sr.setAttr("path", "fill", Ui.color("Text", theme))
                    setting_btn_sr.setAttr("path", "fill", Ui.color("Blue", theme))
                }

                UiSvg{
                    id: setting_btn_sr
                    source: "qtquick/icons/settings.svg"
                    onSourceChanged: setting_btn.icon.source = sourceData;
                    Component.onCompleted: {
                        setAttr("path", "fill", Ui.color("Text", theme))
                    }
                }
            }
        }
    }

}
