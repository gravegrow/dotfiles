import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    aboveWindows: false
    exclusiveZone: implicitWidth

    color: "#0A0A0A"
    implicitWidth: 35
    screen: Quickshell.screens[screenID]

    property string textcolor: "#9A8F8A"
    property string fontfamily: "BerkeleyMono Nerd Font Mono"
    property int screenID: 0

    anchors {
        left: true
        top: true
        bottom: true
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent

        ScratchpadStatus {
            id: scratchpad
        }

        // Item {
        //     height: anchors.margins
        // }

        WorspacesStatus {
            id: workspaces
        }

        Item {
            Layout.fillHeight: true
        }

        Rectangle {
            id: volumecontrol
            color: root.color
            width: root.width
            height: volumetext.height
            anchors.horizontalCenter: parent.horizontalCenter

            readonly property PwNode sink: Pipewire.defaultAudioSink
            property bool isMuted: volumecontrol.sink.audio.volume == 0 || volumecontrol.sink.audio.muted

            Process {
                id: pavu
                command: ["pavucontrol"]
                running: false
            }

            PwObjectTracker {
                id: pwObjectTracker
                objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                onWheel: wheel => {
                    var value = wheel.angleDelta.y > 0 ? 0.01 : -0.01;
                    volumecontrol.sink.audio.volume += value;
                }

                onClicked: mouse => {
                    if (mouse.button === Qt.MiddleButton) {
                        volumecontrol.sink.audio.muted = !volumecontrol.sink.audio.muted;
                    }
                    if (mouse.button === Qt.RightButton) {
                        volumecontrol.sink.audio.volume = 0.30;
                    }
                    if (mouse.button === Qt.LeftButton) {
                        pavu.running = false;
                        pavu.running = true;
                    }
                }
            }

            Text {
                id: volumetext
                anchors.centerIn: parent
                font.family: root.fontfamily
                font.pixelSize: 18
                text: volumecontrol.isMuted ? "󰝟" : "󰕾"
                color: volumecontrol.isMuted ? "#c4746e" : root.textcolor
            }
        }

        TimeStatus {
            id: time
            color: root.color
            size: 12
        }

        Item {
            height: 7
        }
    }
}
