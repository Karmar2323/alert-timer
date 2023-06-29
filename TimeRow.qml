// Copyright (C) 2023 Markus Karjalainen
// License: LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

import QtQuick
import QtQuick.Controls
import TimeAlerter
import "logic.mjs" as Logic

Item {
    id: root
    property string rectColor: "lightblue"

    Item {

        Row {
            id: timeSetupNumbers
            x: 5
            Loader {
                id: hourInputLoader
                sourceComponent: hourMinSecInput
                // limit hours to avoid overflow
                onLoaded: hourInputLoader.item.validator.top = 99
            }
            Text {
                text: "h"
                font.pointSize: 16
                y:5
            }
            Loader {
                id: minInputLoader
                sourceComponent: hourMinSecInput
            }
            Text {
                text: "m"
                font.pointSize: 16
                y:5
            }
            Loader {
                id: secInputLoader
                sourceComponent: hourMinSecInput
                onLoaded: secInputLoader.item.text = "03"
            }
            Text {
                text: "s"
                font.pointSize: 16
                y:5
            }
            Button {
                y: 5
                text: qsTr("Set time")
                onClicked: submitTime()
            }
        }

        Row{
            x: 5
            id: timeSetupButtons
            anchors.top: timeSetupNumbers.bottom
            spacing: 10

            Column{
                Button {
                    y: 5
                    autoRepeat: true
                    text: qsTr("+1 h")
                    onClicked: Logic.addNumberToTextField(hourInputLoader.item, +1)
                }
                Button {
                    y: 5
                    autoRepeat: true
                    text: qsTr("-1 h ")
                    onClicked: Logic.addNumberToTextField(hourInputLoader.item, -1)
                }
            }

            Column{
                Button {
                    y: 5
                    autoRepeat: true
                    text: qsTr("+1 min")
                    onClicked: Logic.addNumberToTextField(minInputLoader.item, +1)
                }
                Button {
                    y: 5
                    autoRepeat: true
                    text: qsTr("-1 min ")
                    onClicked: Logic.addNumberToTextField(minInputLoader.item, -1)
                }
            }

            Column{
                Button {
                    y: 5
                    autoRepeat: true
                    text: qsTr("+1 s")
                    onClicked: Logic.addNumberToTextField(secInputLoader.item, +1)
                }
                Button {
                    y: 5
                    autoRepeat: true
                    text: qsTr("-1 s ")
                    onClicked: Logic.addNumberToTextField(secInputLoader.item, -1)
                }
            }
        }
    }

    Component {
        id: hourMinSecInput
        TextInput {
            focus: true
            font.pointSize: 20
            text: "00"
            maximumLength: 2
            validator: IntValidator{bottom: 0; top: 59}
            onEditingFinished: submitTime()
        }
    }


    function submitTime(){
        let alertTime = Logic.timeToMilliseconds(hourInputLoader.item.text,
                                             minInputLoader.item.text, secInputLoader.item.text)
        Backend.setAlertTime(alertTime)
    }

}
