import QtQuick
import QtQuick.Controls
import QtMultimedia
import Qt.labs.platform

Item {
    id: root
    property alias playing: player.playing
    property alias fileSelector: fileDialog
    property alias audioReady: player.hasAudio
    property url audioFile: ""

    MediaPlayer {
       id: player
       source: Qt.resolvedUrl(audioFile)
       audioOutput: AudioOutput {}
    }
    function playAudio() {
        console.log("playing")
        player.play()
    }

    Timer {
        // wait for media player component and check if media is loaded
        id: fileDialogTimer
        interval: 1000; running: true; repeat: false
        onTriggered: player.hasAudio ? console.log("player has audio") : soundDialog.open()
    }

    FileDialog {
        id: fileDialog
        currentFile: audioFile
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        onAccepted: () => {
                        audioFile = currentFile
                        soundDialog.close()
                    }
        onRejected: soundDialog.close()

    }

    Popup {
        id: soundDialog
        width: 200
        height: 75
        x: 20
        y: 20

        Column {
            Text {
                text: qsTr("No playable sound set for the alarm.\nDo you want to choose a sound file?")
                horizontalAlignment: Text.AlignHCenter
            }

            DialogButtonBox {
                id: noFileDialog
                standardButtons: MessageDialog.Ok | MessageDialog.Cancel
                onAccepted: fileDialog.open()
                onRejected: soundDialog.close()
            }
        }
    }

}
