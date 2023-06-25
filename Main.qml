// Copyright (C) 2023 Markus Karjalainen
// License: LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import TimeAlerter
import "logic.mjs" as Logic

ApplicationWindow {
    id: window
    width: 300
    height: 320
    visible: true
    title: qsTr("Time Alerter")
    property string timeCount: Logic.formatMilliSecondsToTimeString(Backend.timeLeft)
    property string boxColor: "lightgreen"

    GridLayout {
        id: uiGrid
        columns: 2
        rows: 4
        rowSpacing: 10


        Rectangle { color: boxColor; width: 200; height: 80
            id: timeCountRect
            border.color: "gray"
            border.width: 2
            x: 2
            y: 2

            Column {
                Text {
                    x: 5
                    y: 5
                    font.pointSize: 20
                    text: qsTr("Left: ") + window.timeCount
                }

                Text {
                    x: 5
                    text: "Alarm turns off after " + Backend.alarmDuration * 0.001 + " s"
                }

                Slider {
                    id: alarmSlider
                    width: timeCountRect.width - 10
                    x: 5
                    from: 1.0
                    value: 30.0
                    to: 600.0
                    onMoved: Backend.alarmDuration = Math.round(value)* 1000
                }
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


        TimeRow {
            id: timeTextInputs
            width: 16
            height: 16
            x: 10
            rectColor: boxColor
        }

            Rectangle {
                id: startRect
                width: 80; height: 50
                x: 5
                y: 5
                color: Backend.counterOn ? "red" : boxColor
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
                        Loader {
                            sourceComponent: stopButton
                        }

                    }
                }

            }

            Rectangle {

            }

            Rectangle {
                id: radioButtonRect
                color: boxColor
                border.color: "gray"
                border.width: 2
                width: 80
                height: 80


                Column {
                    Text {
                        x: 5
                        y: 5
                        text: qsTr("Alarms:")
                    }

                    CheckBox {
                        x: 5
                        id: popupButton
                        checked: true
                        text: qsTr("Popup")
                    }

                    CheckBox {
                        x: 5
                        id: ledButton
                        checked: Backend.getLedStatus()
                        checkable: true
                        text: qsTr("LED")
                        nextCheckState: () => {
                                            console.log ("ledButton.checked", checked)
                                            // backend checks LED availability
                                                if(checkState === Qt.Checked && Backend.findLED() !== true) {
                                                    ledButton.text = qsTr("LED: error")
                                                    return Qt.Unchecked
                                                }
                                                if (checkState === Qt.Unchecked && Backend.findLED() === true){
                                                    ledButton.text = qsTr("LED")
                                                    return Qt.Checked
                                                }
                                        }
                    }


                }

            }

    }

    Popup {
        id: alertPopup
        x: 10
        y: 50
        width: 200
        height: 100
        modal: false
        focus: true
        closePolicy: Popup.CloseOnEscape || Popup.CloseOnPressOutsideParent
        visible: Backend.alarm && popupButton.checked
        dim: true
        contentItem: Text {
            text: qsTr("ALARM! \n(Press Esc to close or click Stop)")
        }
        onOpened: window.alert(Backend.alarmDuration)

        Loader {
            x: 80
            y: 50
            sourceComponent: stopButton
        }
    }


    Component {
        id: stopButton
        Button {
            text: "Stop"
            onClicked: () => {
                           Backend.stopCounting() //cancel upcoming alarm
                           Backend.alarm = false // stop current alarm
                       }
        }
    }
}
