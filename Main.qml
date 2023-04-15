import QtQuick
import QtQuick.Window
import QtQuick.Controls
import TimeAlerter

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
                    text: "Alert timer: "
                }

                Row {

                    Button {
                        text: "Start"
                        onClicked: () => {
                                       Backend.startCounting()
                                   }
                    }
                    Button {
                        text: "Stop"
                        onClicked: () => {
                                       Backend.stopCounting()
                                   }
                    }

                }
            }


        }

        Rectangle { color: "lightgreen"; width: 80; height: 50

            Column {

                Text {
                    text: "Timeout: " + Backend.defaultTimeout * 0.001 + " s"
                }

                Text {
                    text: "Left: " + Backend.timeLeft * 0.001 + " s"
                }
            }
        }

    }
}
