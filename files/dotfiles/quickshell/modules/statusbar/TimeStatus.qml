import QtQuick
import QtQuick.Layouts

Rectangle {
    id: timestatus
    width: root.width
    color: "#333333"
    height: timeminutes.height + timehours.height + separator.height * 2
    property int size: 12

    anchors.horizontalCenter: parent.horizontalCenter

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            date.visible = true;
            timehours.visible = false;
            timeminutes.visible = false;
            separator.visible = false;
        }
        onExited: {
            date.visible = false;
            timehours.visible = true;
            timeminutes.visible = true;
            separator.visible = true;
        }
    }

    TimeProcess {
        id: timeprocess
    }

    DateStatus {
        id: date
        color: parent.color
        size: timestatus.size
        anchors.centerIn: parent
        visible: false
    }

    Text {
        id: timehours
        anchors.horizontalCenter: parent.horizontalCenter
        text: timeprocess.hours
        color: root.textcolor
        font.bold: true
        font.family: root.fontfamily
        font.pixelSize: timestatus.size
        anchors.bottom: separator.top
    }

    Rectangle {
        id: separator
        height: 1
        width: timehours.width
        color: root.textcolor
        anchors.centerIn: parent
    }

    Text {
        id: timeminutes
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: separator.bottom
        text: timeprocess.minutes
        color: root.textcolor
        font.family: timehours.font.family
        font.pixelSize: timehours.font.pixelSize
        font.bold: timehours.font.bold
    }
}
