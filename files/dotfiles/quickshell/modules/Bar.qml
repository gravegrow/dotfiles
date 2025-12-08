// @pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    anchors {
        left: true
        top: true
        bottom: true
    }

    color: "#0A0A0A"
    implicitWidth: 35
    screen: Quickshell.screens[screenID]

    property string text_color: "#9A8F8A"
    property int screenID: 0

    ColumnLayout {
        id: workspace
        anchors.fill: parent

        // TIME
        Rectangle {
            id: timebox
            width: root.implicitWidth
            height: width * 2
            bottomLeftRadius: 10
            bottomRightRadius: 10
            color: root.color

            ColumnLayout {
                anchors.fill: parent

                Item {
                    Layout.fillHeight: true
                }

                Time {
                    id: time
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: time.hours
                    color: root.text_color
                    font.family: "BerkeleyMono Nerd Font Mono"
                    font.bold: true
                    font.pixelSize: 14
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 16
                    height: 2
                    color: root.text_color
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: time.minutes
                    color: root.text_color
                    font.family: "BerkeleyMono Nerd Font Mono"
                    font.bold: true
                    font.pixelSize: 14
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }

        Item {
            height: 0
        }

        // WORKSPACES

        Repeater {
            id: worskspaces
            model: Hyprland.workspaces.values.filter(w => w.monitor.id == root.screenID)

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: root.implicitWidth - 10
                height: width
                radius: 5
                color: modelData.active ? "#1F1F22" : root.color

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Hyprland.dispatch("workspace " + modelData.id);
                    }
                }

                Text {
                    anchors.centerIn: parent
                    text: root.screenID == 0 ? modelData.id : modelData.id % (10 * root.screenID)
                    color: modelData.active ? "#89B4FA" : "#9A8F8A"
                    font.family: "BerkeleyMono Nerd Font Mono"
                    font.bold: true
                    font.pixelSize: 16
                }
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
