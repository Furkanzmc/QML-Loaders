import QtQuick 2.7

Item {

    // ----- Public Properties ----- //

    property int radius: 25
    property color color: "#FAFAFA"
    property bool useCircle: false

    property alias running: timer.running

    // ----- Private Properties ----- //

    property int _innerRadius: radius * 0.7
    property int _currentIndex: 0

    id: root
    width: radius * 2
    height: radius * 2

    Repeater {
        id: repeater
        model: 8
        delegate: Component {
            Rectangle {
                // ----- Private Properties ----- //
                property int _rotation: (360 / repeater.model) * index
                property int _maxIndex: root._currentIndex + 1
                property int _minIndex: root._currentIndex - 1

                width: root.useCircle ? (root.radius - root._innerRadius) * 2 : root.width - (root._innerRadius * 2)
                height: root.useCircle ? width : width * 0.5
                x: _getPosOnCircle(_rotation).x
                y: _getPosOnCircle(_rotation).y
                radius: root.useCircle ? width : 0
                color: root.color
                opacity: (index >= _minIndex && index <= _maxIndex) || (index === 0 && root._currentIndex + 1 > 7) ? 1 : 0.3
                transform: Rotation {
                    angle: 360 - _rotation
                    origin {
                        x: 0
                        y: height / 2
                    }
                }
                transformOrigin: index >= repeater.model / 2 ? Item.Center : Item.Center

                Behavior on opacity { NumberAnimation { duration: 200 } }
            }
        }
    }

    Timer {
        id: timer
        interval: 80
        repeat: true
        running: true
        onTriggered: {
            if (root._currentIndex === 7) {
                root._currentIndex = 0;
            }
            else {
                root._currentIndex++;
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
