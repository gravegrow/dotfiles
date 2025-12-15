import QtQuick
import Quickshell.Io
import QtQuick.Layouts

Rectangle {
    id: timestatus
    width: root.width
    color: "#333333"
    height: lower.height + upper.height + separator.height * 2
    property int size: 12

    anchors.horizontalCenter: parent.horizontalCenter

    MouseArea {
        id: mousearea
        anchors.fill: parent
        hoverEnabled: true
        property bool showDate
        onEntered: showDate = true
        onExited: showDate = false
    }

    Process {
        id: dateprocess
        command: ["date", "+%H:%M:%d:%a:%b"]
        running: true

        property string hours
        property string minutes
        property string day
        property string weekday
        property string month

        stdout: StdioCollector {
            onStreamFinished: {
                var result = this.text.trim().split(":");
                dateprocess.hours = result[0];
                dateprocess.minutes = result[1];
                dateprocess.day = result[2];
                dateprocess.weekday = result[3].toUpperCase();
                dateprocess.month = result[4];
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateprocess.running = true
    }

    Rectangle {
        id: separator
        height: 1
        width: upper.width
        color: root.textcolor
        anchors.centerIn: parent
    }

    Text {
        id: upper
        anchors.horizontalCenter: parent.horizontalCenter
        text: mousearea.showDate ? dateprocess.day : dateprocess.hours
        color: root.textcolor
        font.bold: true
        font.family: root.fontfamily
        font.pixelSize: timestatus.size
        anchors.bottom: separator.top
    }

    Text {
        id: lower
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: separator.bottom
        height: upper.height
        text: mousearea.showDate ? dateprocess.weekday : dateprocess.minutes
        color: root.textcolor
        font.family: upper.font.family
        font.pixelSize: upper.font.pixelSize
        font.bold: upper.font.bold
    }
}
