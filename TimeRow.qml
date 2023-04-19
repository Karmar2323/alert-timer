import QtQuick
import QtQuick.Controls
import TimeAlerter
import "logic.mjs" as Logic

Item {
    id: root

    Rectangle {
        color: "lightblue"
        width: 150
        height: 32
        Row {
            TextInput {
                id: hourInput
                focus: true
                font.pointSize: 20
                text: "00"
                maximumLength: 2
                validator: IntValidator{bottom: 0; top: 99}

            }
            Text {
                text: "."
                font.pointSize: hourInput.font.pointSize
            }

            Loader {
                id: minInputLoader
                sourceComponent: hourMinSecInput
            }
            Text {
                text: "."
                font.pointSize: hourInput.font.pointSize
            }
            Loader {
                id: secInputLoader
                sourceComponent: hourMinSecInput
            }

            Button {
                text: qsTr("Set time")
                onClicked: Backend.setAlertTime(Logic.timeToMilliseconds(hourInput.text,
                    minInputLoader.item.text, secInputLoader.item.text))
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
        }
    }

}
