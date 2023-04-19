import QtQuick
import QtQuick.Controls
import QtQuick.Window
import TimeAlerter
import "logic.mjs" as Logic

Item {
    id: root
    //property int sliderValuesAsSeconds: 0

    Column {

        Row {
            id: sliderRow
            spacing: 4

            Column {

                Slider {
                    id: hourSlider
                    from: 0.0
                    value: 0.0
                    to: 1.0
                }
                Text {
                    text: Math.round(hourSlider.value * 72) + " h"
                }

            }

            Column {

                Slider {
                    id: minSlider
                    from: 0.0
                    value: 0.0
                    to: 1.0
                }

                Text {
                    text: Math.floor(minSlider.value * 60) + " min"
                }

            }


            Column {
                Slider {
                    id: secSlider
                    from: 0.0
                    value: 0.05
                    to: 1.0
                }

                Text {
                    text: Math.floor(secSlider.value * 60) + " s"
                }

            }

            Column {

                Button {
                    text: qsTr("Set timeout")
                    //onClicked: Backend.setAlertTime(Math.floor(minSlider.value * 3600000) + Math.floor(secSlider.value * 60000))
                    onClicked: Backend.setAlertTime(Logic.timeToMilliseconds(hourSlider.value, minSlider.value, secSlider.value))// TODO fix hours

                }
            }
        }

        TimeRow {
            id: timeTextInputs
            width: 16
            height: 16
        }
    }
}
