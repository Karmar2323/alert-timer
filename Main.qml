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
    property string copyright: "Copyright (C) 2023 Markus Karjalainen"

    background: Rectangle {
        color: "darkgray"
    }

    header: ToolBar {
        Flow {
            anchors.fill: parent

            ToolButton {
                text: qsTr("Start")
                onClicked: Backend.startCounting()
            }

            ToolButton {
                id: toolBarStop
                text: qsTr("Stop")
                onClicked: Logic.stopAlarm(Backend)
            }

            CheckBox {
                height: toolBarStop.height
                id: popupButton
                checked: true
                text: qsTr("Popup ")
            }

            CheckBox {
                height: toolBarStop.height
                id: ledButton
                checked: Backend.getLedStatus()
                checkable: true
                text: qsTr("LED ")
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

    menuBar: MenuBar {
        Menu {
            id: menu
            title: qsTr("Info")

            ToolButton {
                text: qsTr("About")
                onClicked: aboutDialog.open()
            }

            ToolButton {
                text: qsTr("License")
                onClicked: licenseDialog.open()
            }

        }

        Menu {
            id: settingMenu
            title: qsTr("Settings")

            ToolButton {
                text: alarmWindow.visible ? qsTr("Hide extra window") : qsTr("Show extra window")
                onClicked: () => {
                               alarmWindow.visible = !alarmWindow.visible
                               if(alarmWindow.visible) {
                                   alarmWindow.raise()
                                   alarmWindow.x = screen.width - 2 * alarmWindow.width
                                   alarmWindow.y = screen.height - 2 * alarmWindow.height
                               }
                           }
            }

        }
    }

    Window {
        id: alarmWindow
        width: 160
        height: 100
        transientParent: null
        visible: true
        x: screen.width - alarmWindow.width
        y: screen.height - alarmWindow.height

        Rectangle {
            id: alarmRect
            color: Backend.alarm ? "red" : "yellow"
            width: 80
            height: 80
            border.color: "gray"
            border.width: 5
            radius: 50

            Text {
                text: qsTr("ALARM!")
                color: "yellow"
                anchors.verticalCenter: alarmRect.verticalCenter
                anchors.horizontalCenter: alarmRect.horizontalCenter
                font.bold: true

                SequentialAnimation on font.pixelSize {
                    loops: Animation.Infinite
                    PropertyAnimation { to: 20 }
                    PropertyAnimation { to: 12 }
                }
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

    GridLayout {
        id: uiGrid
        columns: 2
        rows: 4
        rowSpacing: 10


        Rectangle {
            color: Backend.counterOn ? "green" : boxColor
            width: 200
            height: 200
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
                    to: 1800.0
                    onMoved: Backend.alarmDuration = Math.round(value)* 1000
                }

                Row {
                    x: parent.width * 0.32

                    Button {
                        text: "Start"
                        onClicked: Backend.startCounting()
                    }
                    Loader {
                        sourceComponent: stopButton
                    }

                }

                TimeRow {
                    id: timeTextInputs
                    width: 16
                    height: 16
                    y: 5
                    rectColor: boxColor
                }
            }

        }

    }

    Popup {
        id: alertPopup
        x: 10
        y: 50
        width: 200
        height: 120
        modal: false
        focus: true
        closePolicy: Popup.CloseOnEscape || Popup.CloseOnPressOutsideParent
        visible: Backend.alarm && popupButton.checked
        dim: true
        contentItem:
            Rectangle{
                Column{

                    Text {
                        id: alarmText
                        text: qsTr("ALARM!")
                        color: "red"
                        font.bold: true
                        font.pixelSize: 32
                        x: 40

                        SequentialAnimation on x {
                            loops: Animation.Infinite
                            PropertyAnimation { to: 40 }
                            PropertyAnimation { to: 20 }
                        }
                    }

                    Text{
                         text: "\n(Press Esc to close or click Stop)"
                    }

                    Loader {
                        x: 80
                        sourceComponent: stopButton
                    }
                }



        }


        onOpened: window.alert(Backend.alarmDuration)


    }


    Component {
        id: stopButton
        Button {
            text: "Stop"
            onClicked: Logic.stopAlarm(Backend)
        }
    }


    Dialog {
        id: licenseDialog
        title: qsTr("License")
        Label {
            anchors.fill: parent
            text: qsTr("License: \nLGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only")
            horizontalAlignment: Text.AlignHCenter
        }

        standardButtons: Dialog.Ok
    }

    Dialog {
        id: aboutDialog
        title: qsTr("About")
        Label {
            anchors.fill: parent
            text: window.title + qsTr("\n\n" + window.copyright) + qsTr("\n\nSource code repository: \nhttps://github.com/Karmar2323/alert-timer")
            horizontalAlignment: Text.AlignHCenter
        }

        standardButtons: Dialog.Ok
    }

}
