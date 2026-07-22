import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland

// qmllint disable uncreatable-type
PanelWindow {
    anchors {
        top: true
    }

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    implicitHeight: 40
    implicitWidth: 300

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: "#0a0a0a"
    }

    Text {
        anchors.centerIn: parent
        color: "#998e89"
        text: Qt.formatDateTime(clock.date, "hh:mm")

        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    }
}
