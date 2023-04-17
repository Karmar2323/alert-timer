import QtQuick
import QtQuick.Window
import QtQuick.Controls
import TimeAlerter
import "logic.mjs" as Logic

Window {
    id: window
    width: 400
    height: 300
    visible: true
    title: qsTr("Time Alerter")

    Grid {
        id: uiGrid
        columns: 2
        rows: 2
        spacing: 10
        padding: 10


        Rectangle {
            id: startRect
            width: 80; height: 50
            color: Backend.counterOn ? "red" : "lightgreen"
            radius: 1.5
            Column {
                spacing: 2

                Text {
                    text: qsTr("Alert timer: ")
                }

                Row {

                    Button {
                        text: "Start"
                        onClicked: Backend.startCounting()
                    }
                    Button {
                        text: "Stop"
                        onClicked: Backend.stopCounting()
                    }

                }
            }

        }

        Rectangle { color: "lightgreen"; width: 100; height: 50

            Column {

                Text {
                    text: qsTr("Timeout: " + Backend.defaultTimeout * 0.001 + " s")
                }

                Text {
                    text: qsTr("Left: " + Logic.formatMilliSecondsToTimeString(Backend.timeLeft))
                }
            }
        }

        Rectangle {
            id: alarmRect
            color: Backend.alarm ? "red" : "yellow"
            width: 80
            height: 80
            border.color: "black"
            border.width: 5
            radius: 50

            Text {
                text: qsTr("ALARM!")
                color: "yellow"
                anchors.verticalCenter: alarmRect.verticalCenter
                anchors.horizontalCenter: alarmRect.horizontalCenter
                font.bold: true
            }

            Text {
                text: "OFF"
                color: "black"
                anchors.verticalCenter: alarmRect.verticalCenter
                anchors.horizontalCenter: alarmRect.horizontalCenter
                font.bold: true
                opacity: Backend.alarm || (!Backend.alarm && Backend.counterOn) ? 0 : 1
            }

            Text {
                text: Backend.timeLeft * 0.001 + " s"
                color: "black"
                anchors.verticalCenter: alarmRect.verticalCenter
                anchors.horizontalCenter: alarmRect.horizontalCenter
                font.bold: true
                opacity: Backend.counterOn ? 1 : 0
            }
        }

    }

}
