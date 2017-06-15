import QtQuick 2.7

Item {

    // ----- Public Properties ----- //

    property int radius: 25
    property bool useDouble: false
    property bool running: true

    property color color: "white"

    // ----- Private Properties ----- //

    property int _innerRadius: radius * 0.7
    property int _circleRadius: (radius - _innerRadius) * 0.5

    id: root
    width: radius * 2
    height: radius * 2
    onRunningChanged: {
        if (running === false) {
            for (var i = 0; i < repeater.model; i++) {
                if (repeater.itemAt(i)) {
                    repeater.itemAt(i).stopAnimation();
                }
            }
        }
        else {
            for (var i = 0; i < repeater.model; i++) {
                if (repeater.itemAt(i)) {
                    repeater.itemAt(i).playAnimation();
                }
            }
        }
    }

    Repeater {
        id: repeater
        model: root.useDouble ? 10 : 4
        delegate: Component {
            Rectangle {
                // ----- Private Properties ----- //
                property int _currentAngle: _getStartAngle()

                id: rect
                width: _getWidth()
                height: width
                radius: width
                color: root.color
                transformOrigin: Item.Center
                x: root._getPosOnCircle(_currentAngle).x
                y: root._getPosOnCircle(_currentAngle).y
                antialiasing: true

                SequentialAnimation {
                    id: anim
                    loops: Animation.Infinite

                    NumberAnimation {
                        target: rect
                        property: "_currentAngle"
                        duration: root.useDouble ? 1800 : 1000
                        from: rect._getStartAngle()
                        to: 360 + rect._getStartAngle()
                        easing.type: Easing.OutQuad
                    }

                    PauseAnimation { duration: 500 }
                }

                // ----- Public Functions ----- //

                function playAnimation() {
                    if (anim.running == false) {
                        anim.start();
                    }
                    else if (anim.paused) {
                        anim.resume();
                    }
                }

                function stopAnimation() {
                    if (anim.running) {
                        anim.pause();
                    }
                }

                // ----- Private Functions ----- //

                function _getStartAngle() {
                    var ang = 90;
                    if (root.useDouble) {
                        ang = index < 5 ? 90 : 270;
                    }

                    return ang;
                }

                function _getWidth() {
                    var w = (root._circleRadius) * 0.5 * (repeater.model - index);
                    if (root.useDouble) {
                        w = (root._circleRadius) * 0.5 * ((repeater.model / 2) - Math.abs(repeater.model / 2 - index))
                    }

                    return w;
                }
            }
        }
    }

    Timer {
        // ----- Private Properties ----- //
        property int _circleIndex: 0

        id: timer
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            var maxIndex = root.useDouble ? repeater.model / 2 : repeater.model;
            if (_circleIndex === maxIndex) {
                stop();
                _circleIndex = 0;
            }
            else {
                repeater.itemAt(_circleIndex).playAnimation();
                if (root.useDouble) {
                    repeater.itemAt(repeater.model - _circleIndex - 1).playAnimation();
                }

                _circleIndex++;
            }
        }
    }

    // ----- Private Functions ----- //

    function _toRadian(degree) {
        return (degree * 3.14159265) / 180.0;
    }

    function _getPosOnCircle(angleInDegree) {
        var centerX = root.width / 2, centerY = root.height / 2;
        var posX = 0, posY = 0;

        posX = centerX + root._innerRadius * Math.cos(_toRadian(angleInDegree));
        posY = centerY - root._innerRadius * Math.sin(_toRadian(angleInDegree));
        return Qt.point(posX, posY);
    }
}
