import QtQuick
import QtQuick.Window
import QtQuick.Controls
import TimeAlerter
import "logic.mjs" as Logic

ApplicationWindow {
    id: window
    width: 400
    height: 300
    visible: true
    title: qsTr("Time Alerter")
    property string timeCount: Logic.formatMilliSecondsToTimeString(Backend.timeLeft)

    Grid {
        id: uiGrid
        columns: 3
        rows: 3
        spacing: 10
        padding: 10

        Rectangle {
            id: startRect
            width: 80; height: 50
            color: Backend.counterOn ? "red" : "lightgreen"
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
                        onClicked: () => {
                                       Backend.stopCounting() //cancel upcoming alarm
                                       Backend.alarm = false // stop current alarm
                                   }
                    }

                }
            }

        }

        Rectangle { color: "lightgreen"; width: 150; height: 50

            Column {

                Text {
                    text: qsTr("Timeout: " + Backend.defaultTimeout * 0.001 + " s")
                }

                Text {
                    text: qsTr("Left: ") + window.timeCount
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
                text: window.timeCount
                color: "black"
                anchors.verticalCenter: alarmRect.verticalCenter
                anchors.horizontalCenter: alarmRect.horizontalCenter
                font.bold: true
                opacity: Backend.counterOn ? 1 : 0
            }
        }

    }

    TimeRow {
        id: timeTextInputs
        width: 16
        height: 16
        anchors.top: uiGrid.bottom
        x: 10
    }

    Popup {
        id: alertPopup
        x: 100
        y: 100
        width: 200
        height: 150
        modal: false
        focus: true
        closePolicy: Popup.CloseOnEscape || Popup.CloseOnPressOutsideParent
        visible: Backend.alarm
        dim: true
        contentItem: Text {
            text: qsTr("ALARM! \n(Press Esc to close or click Stop)")
        }
    }


}
