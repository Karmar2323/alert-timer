import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import TimeAlerter
import "logic.mjs" as Logic

ApplicationWindow {
    id: window
    width: 400
    height: 300
    visible: true
    title: qsTr("Time Alerter")
    property string timeCount: Logic.formatMilliSecondsToTimeString(Backend.timeLeft)

    GridLayout {
        id: uiGrid
        columns: 3
        rows: 3
        rowSpacing: 10

        Rectangle {
            id: startRect
            width: 80; height: 50
            x: 5
            y: 5
            color: Backend.counterOn ? "red" : "lightblue"
            border.color: "gray"
            border.width: 2
            Column {
                spacing: 2

                Text {
                    x: 5
                    y: 5
                    text: qsTr("Alert timer: ")
                }

                Row {
                    x: 5
                    y: 5

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

        Rectangle { color: "lightblue"; width: 200; height: 50
            border.color: "gray"
            border.width: 2
            x: 2
            y: 2

            Text {
                x: 5
                y: 5
                font.pointSize: 20
                text: qsTr("Left: ") + window.timeCount
            }
        }

        Rectangle {
            id: alarmRect
            color: Backend.alarm ? "red" : "yellow"
            width: 80
            height: 80
            x: 2
            y: 2
            border.color: "gray"
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
                color: "gray"
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
