import QtQuick
import QtQuick.Controls
import TimeAlerter
import "logic.mjs" as Logic

Item {
    id: root

    Rectangle {
        color: "lightblue"
        width: 200
        height: 90
        border.color: "gray"
        border.width: 2

        Row {
            id: timeSetupNumbers
            TextInput {
                id: hourInput
                focus: true
                x: 5
                font.pointSize: 20
                text: "00"
                maximumLength: 2
                validator: IntValidator{bottom: 0; top: 99}
                onEditingFinished: submitTime()


            }
            Text {
                text: "h"
                font.pointSize: 16
            }
            Loader {
                id: minInputLoader
                sourceComponent: hourMinSecInput
            }
            Text {
                text: "m"
                font.pointSize: 16
            }
            Loader {
                id: secInputLoader
                sourceComponent: hourMinSecInput
            }
            Text {
                text: "s"
                font.pointSize: 16
            }
            Button {
                y: 5
                text: qsTr("Set time")
                onClicked: submitTime()
            }
        }

        Row{
            id: timeSetupButtons
            anchors.top: timeSetupNumbers.bottom

            Column{
                Button {
                    y: 5
                    text: qsTr("+1 h")
                    onClicked: () => {
                                   let temp = Number.parseInt(hourInput.text)
                                   if(temp > 98) {
                                       return
                                   }

                                   hourInput.text = (temp + 1).toString()
                                   console.log(hourInput.text)
                               }
                }
                Button {
                    y: 5
                    text: qsTr("-1 h")
                    onClicked: () => {
                                   let temp = Number.parseInt(hourInput.text)
                                   if(temp < 1) {
                                       return
                                   }

                                   hourInput.text = (temp - 1).toString()
                                   console.log(hourInput.text)
                               }
                }
            }


        }
    }

    Component {
        id: hourMinSecInput
        TextInput {
            focus: true
            font.pointSize: 20
            text: "30"
            maximumLength: 2
            validator: IntValidator{bottom: 0; top: 59}
            onEditingFinished: submitTime()
        }
    }

    function submitTime(){
        Backend.setAlertTime(Logic.timeToMilliseconds(hourInput.text,
                            minInputLoader.item.text, secInputLoader.item.text))
    }
}
