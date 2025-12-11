import QtQuick
import Quickshell
import Quickshell.Hyprland

Rectangle {
    id: scratchstatus
    height: root.width
    width: root.width
    radius: 3
    anchors.horizontalCenter: parent.horizontalCenter
    color: root.color

    property string maincolor: "#957FB8"
    property string hover: "#D27E99"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: scratchtext.color = scratchstatus.hover
        onExited: scratchtext.color = scratchstatus.maincolor
        onClicked: Hyprland.dispatch("togglespecialworkspace scratchpad")
    }

    Text {
        id: scratchtext
        anchors.centerIn: parent
        text: "󰍜"
        color: maincolor
        font.family: root.font
        font.pixelSize: 15
    }
}
