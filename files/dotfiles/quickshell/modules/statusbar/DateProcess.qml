import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property string day
    property string month
    property string weekday

    Process {
        id: dateProc
        command: ["date", "+%d:%a:%b"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var result = this.text.trim().split(":");
                root.day = result[0];
                root.weekday = result[1].toUpperCase();
                root.month = result[2].toUpperCase();
            }
        }
    }
}
