import QtQuick
import QtQuick.Controls 2.0
import QtQuick.Window
import TimeAlerter

Item {
    id: root
    property int sliderValuesAsSeconds: 0

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
                onClicked: Backend.setAlertTime(Math.floor(minSlider.value * 3600000) + Math.floor(secSlider.value * 60000))
//                onClicked: Backend.setAlertTime((Math.round(hourSlider.value) * 72 * 3600000) + Math.floor(minSlider.value * 3600000) + Math.floor(secSlider.value * 60000))// TODO fix hours

            }

        }

    }
}
