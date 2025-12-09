import QtQuick
import QtQuick.Layouts

Rectangle {
    width: 30
    height: 73

    topRightRadius: 5
    bottomRightRadius: 5

    TimeProcess {
        id: time
    }

    ColumnLayout {
        anchors.fill: parent

        Item {
            Layout.fillHeight: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: time.hours
            color: root.textcolor
            font.family: root.fontfamily
            font.bold: true
            font.pixelSize: 14
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 16
            height: 1
            color: root.textcolor
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: time.minutes
            color: root.textcolor
            font.family: root.fontfamily
            font.bold: true
            font.pixelSize: 14
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
