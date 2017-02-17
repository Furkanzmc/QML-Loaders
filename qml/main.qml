import QtQuick 2.7
import QtQuick.Window 2.2
import "Loaders"

Window {
    id: mainWindow
    visible: true
    width: 320
    height: 480
    title: qsTr("QML Loaders")
    color: "#8BC34A"
    Component.onCompleted: {
        if (QML_DEBUG) {
            QM.setWindow(mainWindow)
        }
    }

    Text {
        text: "Refresh"
        anchors {
            left: parent.left
            top: parent.top
        }
        font.pointSize: 13
        visible: QML_DEBUG

        MouseArea {
            anchors.fill: parent
            onClicked: {
                QM.reload();
            }
        }
    }

    Row {
        id: rowOne
        width: 30 + 30 + 40 + 50 + (40 * 3)
        height: 50
        anchors {
            top: parent.top
            topMargin: 100
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 40

        SharinganLoader {
            radius: 15
        }

        PulseLoader {
            width: barCount * 10
            height: 30
            barCount: 3
            spacing: 2
        }

        PulseLoader {
            width: barCount * 10
            height: 30
            barCount: 4
            spacing: 2
        }

        PulseLoader {
            width: barCount * 10
            height: 30
            barCount: 5
            spacing: 2
        }
    }

    Row {
        id: rowTwo
        width: 30 + 30 + 40 + 50 + (40 * 3)
        height: 50
        anchors {
            top: rowOne.bottom
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 35

        SharinganLoader {
            radius: 15
            useCircle: true
        }

        LineSpinner {
            width: 40
            height: 40
        }

        FishSpinner {
            radius: 25
        }

        FishSpinner {
            radius: 25
            useDouble: true
        }
    }

    Row {
        width: 30 + 30 + 40 + 50 + (40 * 3)
        height: 50
        anchors {
            top: rowTwo.bottom
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 35

        BlockLoader {
            width: 50
            height: 20
        }

        RectangleLoader {
            width: 50
            height: 50
        }
    }
}
