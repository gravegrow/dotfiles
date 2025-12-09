import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    aboveWindows: false
    exclusiveZone: implicitWidth

    color: "#0d0c0c"
    implicitWidth: 30
    screen: Quickshell.screens[screenID]

    property string textcolor: "#DCD7BA"
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

        Item {
            height: 5
        }

        WorspacesStatus {
            id: workspaces
        }

        Item {
            Layout.fillHeight: true
        }

        TimeStatus {
            id: time
            color: "#16161D"
            width: width - 3
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
