import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property string hours
    property string minutes

    Process {
        id: dateProc
        command: ["date", "+%H:%M"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var result = this.text.trim().split(":");
                root.hours = result[0];
                root.minutes = result[1];
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
