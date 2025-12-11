import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    width: 35
    height: day.height + weekday.height + 5
    color: "#0A0A0A"
    property string textcolor: "#9A8F8A"
    property string fontfamily: "BerkeleyMono Nerd Font Mono"
    property int size: 13

    DateProcess {
        id: date
    }

    ColumnLayout {
        anchors.fill: parent

        Text {
            id: day
            anchors.horizontalCenter: parent.horizontalCenter
            text: date.day
            color: root.textcolor
            font.bold: true
            font.family: root.fontfamily
            font.pixelSize: root.size
        }

        Text {
            id: weekday
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: day.bottom
            text: date.weekday
            color: root.textcolor
            font.family: day.font.family
            font.pixelSize: day.font.pixelSize * 0.7
            font.bold: day.font.bold
        }
    }
}
