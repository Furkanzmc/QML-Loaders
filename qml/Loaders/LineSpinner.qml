import QtQuick 2.7

Item {

    // ----- Public Properties ----- //

    property int lineThickness: 2
    property alias color: line.color

    id: root
    Component.onCompleted: rotationAnimation.start()

    Rectangle {
        id: line
        width: root.width / 2
        height: root.lineThickness
        x: root.width / 2
        y: root.height / 2
        transformOrigin: Item.Left
        antialiasing: true
    }

    NumberAnimation {
        id: rotationAnimation
        target: line
        property: "rotation"
        duration: 1500
        from: 0
        to: 360
        easing.type: Easing.OutExpo
        loops: Animation.Infinite
    }
}
