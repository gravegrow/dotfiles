import Quickshell
import QtQuick

import "./modules/statusbar"

ShellRoot {
    id: config

    Loader {
        active: true
        sourceComponent: Statusbar {
            screenID: 0
        }
    }

    Loader {
        active: true
        sourceComponent: Statusbar {
            screenID: 1
        }
    }
}
