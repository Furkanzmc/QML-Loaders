import QtQuick 2.7
import "Loaders"

ListView {

    // ----- Private Properties ----- //

    property var _colors: ["#FF4CA7", "#ED87E7", "#FF716D", "#52CBE5"]
    property var _components: [
        {"component": sharinganComponent, "title": "Sharingan Loader"},
        {"component": pulseThree, "title": "Pulse Loader"},
        {"component": pulseFour, "title": "Pulse Loader 4 Bars"},
        {"component": pulseFive, "title": "Pulse Loader 5 Bars"},
        {"component": classicLoader, "title": "Classic Loader"},
        {"component": lineLoader, "title": "Line Loader"},
        {"component": fishSpinner, "title": "Fish Spinner"},
        {"component": fishSpinnerDouble, "title": "Double Fish Spinner"},
        {"component": blockLoader, "title": "Block Loader"},
        {"component": rectLoader, "title": "Rectangle Loader"}
    ]

    id: root
    model: _components.length
    spacing: SH.dp(10)
    delegate: Component {
        DemoCard {
            width: parent.width
            height: SH.dp(60)
            title: root._components[index].title
            color: root._colors[root.getRandomInt(1, root._colors.length) - 1]
            loaderComponent: root._components[index].component
        }
    }
    clip: true


    // ----- Components ----- //

    Component {
        id: sharinganComponent
        SharinganLoader { radius: SH.dp(15) }
    }
    Component {
        id: pulseThree
        PulseLoader { width: barCount * SH.dp(10); height: SH.dp(30); barCount: 3; spacing: SH.dp(2) }
    }
    Component {
        id: pulseFour
        PulseLoader { width: barCount * SH.dp(10); height: SH.dp(30); barCount: 4; spacing: SH.dp(2) }
    }
    Component {
        id: pulseFive
        PulseLoader { width: barCount * SH.dp(10); height: SH.dp(30); barCount: 5; spacing: SH.dp(2) }
    }

    Component {
        id: classicLoader
        SharinganLoader { radius: SH.dp(15); useCircle: true }
    }
    Component {
        id: lineLoader
        LineSpinner { width: SH.dp(40); height: width; lineThickness: SH.dp(2) }
    }
    Component {
        id: fishSpinner
        FishSpinner { radius: SH.dp(25) }
    }
    Component {
        id: fishSpinnerDouble
        FishSpinner { radius: SH.dp(25); useDouble: true }
    }

    Component {
        id: blockLoader
        BlockLoader { width: SH.dp(50); height: SH.dp(20) }
    }
    Component {
        id: rectLoader
        RectangleLoader { width: SH.dp(50); height: SH.dp(50) }
    }

    // ----- Private Functions ----- //

    /**
     * Returns a random integer between min (inclusive) and max (inclusive)
     * Using Math.round() will give you a non-uniform distribution!
     */
    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }
}
