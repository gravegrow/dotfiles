import Quickshell
import QtQuick
import "./modules"

ShellRoot {
    id: config

    Loader {
        active: true
        sourceComponent: Bar {
            screenID: 0
        }
    }

    Loader {
        active: true
        sourceComponent: Bar {
            screenID: 1
        }
    }
}
