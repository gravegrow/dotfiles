import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    width: 35
    height: 93
    color: "#0a0a0a"
    property string textcolor: "#9A8F8A"

    DateProcess {
        id: date
    }

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillHeight: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: date.weekday
            color: root.textcolor
            font.family: "BerkeleyMono Nerd Font Mono"
            font.bold: true
            font.pixelSize: 11
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 16
            height: 2
            color: root.textcolor
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: date.day
            color: root.textcolor
            font.family: "BerkeleyMono Nerd Font Mono"
            font.bold: true
            font.pixelSize: 14
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 16
            height: 2
            color: root.textcolor
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: date.month
            color: root.textcolor
            font.family: "BerkeleyMono Nerd Font Mono"
            font.bold: true
            font.pixelSize: 11
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
