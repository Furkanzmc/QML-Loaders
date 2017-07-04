import QtQuick 2.7

Item {

    // ----- Public Properties ----- //

    property int lineThickness: 2
    property color color: "white"
    property alias running: rotationAnimation.paused

    property bool turnClockwise: true

    id: root

    Rectangle {
        id: line
        color: root.color
        width: root.lineThickness
        height: root.width / 2
        x: root.width / 2
        y: root.height / 2
        transformOrigin: Item.Top
        rotation: 180
        antialiasing: true
    }

    Rectangle {
        id: hourLine
        color: root.color
        width: root.lineThickness
        height: root.width / 3
        x: root.width / 2
        y: root.height / 2
        transformOrigin: Item.Top
        rotation: 180
        antialiasing: true
    }

    NumberAnimation {
        id: rotationAnimation
        target: line
        property: "rotation"
        duration: 500
        from: 180 * (root.turnClockwise ? 1 : -1)
        to: 540 * (root.turnClockwise ? 1 : -1)
        running: true
        easing.type: Easing.Linear
        loops: Animation.Infinite
    }

    NumberAnimation {
        id: hourAnimation
        target: hourLine
        property: "rotation"
        duration: 6000
        from: 180 * (root.turnClockwise ? 1 : -1)
        to: 540 * (root.turnClockwise ? 1 : -1)
        running: rotationAnimation.running
        paused: rotationAnimation.paused
        easing.type: Easing.Linear
        loops: Animation.Infinite
    }
}

