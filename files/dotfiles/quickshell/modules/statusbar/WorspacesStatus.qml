import Quickshell.Hyprland
import QtQuick

Repeater {
    id: holder
    model: Hyprland.workspaces.values.filter(w => w.monitor.id == root.screenID && w.id >= 0)

    property string activecolor: "#7E9CD8"
    property string occupiedcolor: "#727169"
    property string hovercolor: "#D27E99"

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.width
        height: indextext.height
        color: root.color

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                Hyprland.dispatch("workspace " + modelData.id);
            }
            onEntered: indextext.entered = true
            onExited: indextext.entered = false
        }

        Text {
            id: indextext
            anchors.centerIn: parent
            text: root.screenID == 0 ? modelData.id : modelData.id % (10 * root.screenID)
            color: entered ? holder.hovercolor : (modelData.active ? holder.activecolor : holder.occupiedcolor)
            font.family: root.fontfamily
            font.bold: true
            font.pixelSize: 16
            property bool entered: false
        }
    }
}
