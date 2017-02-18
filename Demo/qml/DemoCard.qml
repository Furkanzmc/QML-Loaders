import QtQuick 2.7

Rectangle {

    // ----- Public Properties ----- //

    property alias title: lbTitle.text
    property var loaderComponent: undefined
    readonly property bool opened: root.state === "open"

    // ----- Private Properties ----- //

    property int _height: 0

    id: root
    radius: SH.dp(7)
    clip: true
    states: [
        State {
            name: "open"
            PropertyChanges { target: root; height: root._height + loader.item.height }
            PropertyChanges { target: lbTitle; opacity: 0 }
            PropertyChanges { target: loader; opacity: 1 }
        }
    ]
    transitions: [
        Transition {
            from: "*"; to: "open"

            NumberAnimation { target: root; property: "height"; duration: 300; easing.type: Easing.OutBack }
            NumberAnimation { target: loader; property: "opacity"; duration: 300; easing.type: Easing.OutBack }
            NumberAnimation { target: lbTitle; property: "opacity"; duration: 300; easing.type: Easing.OutBack }
        },
        Transition {
            from: "open"; to: "*"

            NumberAnimation { target: root; property: "height"; duration: 300; easing.type: Easing.InBack }
            NumberAnimation { target: loader; property: "opacity"; duration: 300; easing.type: Easing.InBack }
            NumberAnimation { target: lbTitle; property: "opacity"; duration: 300; easing.type: Easing.InBack }
        }
    ]

    Component.onCompleted: {
        root._height = root.height;
    }

    Text {
        id: lbTitle
        color: "white"
        font {
            pixelSize: SH.dp(15)
        }
        anchors {
            top: parent.top
            left: parent.left
            topMargin: SH.dp(10)
            leftMargin: SH.dp(10)
        }
    }

    Loader {
        id: loader
        anchors.centerIn: parent
        opacity: 0
        visible: !(opacity === 0)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (loader.sourceComponent === null) {
                loader.sourceComponent = root.loaderComponent;
            }

            root.state = root.state === "open" ? "" : "open";
        }
    }
}
