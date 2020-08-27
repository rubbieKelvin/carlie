import QtQuick 2.0

Item{
    signal dateUpdated(var datetime)

    Timer{
        interval: 250
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: dateUpdated(new Date());
    }
}
