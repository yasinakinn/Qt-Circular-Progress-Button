import QtQuick 2.15
import QtQuick.Shapes 2.15
import Qt5Compat.GraphicalEffects

Item {
    id: progress
    implicitHeight: buttonSize
    implicitWidth: buttonSize

    // Signals
    signal pressAndHold
    signal pressAndHoldCustom
    signal pressEnd
    signal released

    // Properties
    // General
    property int buttonSize: 250
    property int circleSize: 10
    property bool roundCap: true
    property bool status: false
    property int startAngle: -90
    property real maxValue: 100
    property real value: 0

    property url iconSource: ""

    // Drop Shadow
    property bool enableDropShadow: true
    property color dropShadowColor: "#20000000"
    property int dropShadowRadius: circleSize

    // Bg Circle
    property color bgStorkeColor: "#7e7e7e"
    property int strokeBgWidth: circleSize
    property color bgColor: "transparent"
    property color innerCircleColor: "white"

    // Progress Circle
    property color progressColor: "#399fff"
    property int progressWidth: circleSize

    QtObject {
        id: internal

        property Component dropShadow: DropShadow {
            color: progress.dropShadowColor
            fast: true
            verticalOffset: 0
            horizontalOffset: 0
            samples: 12
            radius: progress.dropShadowRadius
        }
    }

    Shape {
        id: shape
        anchors.fill: parent
        antialiasing: true
        layer.enabled: true
        layer.samples: 4
        asynchronous: true
        layer.effect: progress.enableDropShadow ? internal.dropShadow : null

        ShapePath {
            id: pathBg
            strokeColor: progress.bgStorkeColor
            fillColor: progress.bgColor
            strokeWidth: progress.strokeBgWidth
            capStyle: progress.roundCap ? ShapePath.RoundCap : ShapePath.FlatCap
            joinStyle: ShapePath.RoundJoin
            PathAngleArc {
                radiusX: (progress.width / 2) - (pathBg.strokeWidth / 2)
                radiusY: (progress.height / 2) - (pathBg.strokeWidth / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: 360
            }
        }

        ShapePath {
            id: path
            strokeColor: progressColor
            fillColor: progress.bgColor
            strokeWidth: progress.progressWidth
            capStyle: progress.roundCap ? ShapePath.RoundCap : ShapePath.FlatCap
            joinStyle: ShapePath.RoundJoin
            PathAngleArc {
                radiusX: (progress.width / 2) - (progress.progressWidth / 2)
                radiusY: (progress.height / 2) - (progress.progressWidth / 2)
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: progress.startAngle
                sweepAngle: (360 / progress.maxValue * progress.value)
            }
        }

        ShapePath {
            id: pathInner
            strokeColor: progress.innerCircleColor
            fillColor: progress.bgColor
            strokeWidth: progress.progressWidth / 3
            capStyle: progress.roundCap ? ShapePath.RoundCap : ShapePath.FlatCap
            joinStyle: ShapePath.RoundJoin
            PathAngleArc {
                radiusX: (progress.width / 2) - (progress.progressWidth / 2) - 10
                radiusY: (progress.height / 2) - (progress.progressWidth / 2) - 10
                centerX: progress.width / 2
                centerY: progress.height / 2
                startAngle: 0
                sweepAngle: 360
            }
        }

        Image {
            id: icon
            anchors.fill: parent
            source: progress.iconSource
            fillMode: Image.PreserveAspectFit
        }

        MouseArea {
            id: mouseArea
            property int pressAndHoldDuration: 10
            anchors.verticalCenter: parent.verticalCenter
            pressAndHoldInterval: 1005
            z: 3
            anchors.horizontalCenter: parent.horizontalCenter
            width: progress.implicitHeight
            height: progress.implicitHeight
            propagateComposedEvents: true
            onPressAndHold: progress.pressAndHold()
            onPressed: pressAndHoldTimer.restart()
            onReleased: relasedTimer.restart()
            Timer {
                id: pressAndHoldTimer
                interval: parent.pressAndHoldDuration
                running: false
                repeat: true
                onTriggered: {
                    progress.pressAndHoldCustom()
                }
            }

            Timer {
                id: relasedTimer
                interval: parent.pressAndHoldDuration
                running: false
                repeat: true
                onTriggered: {
                    progress.released()
                }
            }
        }
    }

    onPressAndHoldCustom: {
        if (progress.status == true) {
            progress.value -= 1
            if (progress.value <= 0) {
                pressAndHoldTimer.stop()
                progress.status = false
                progress.pressEnd()
            }
        } else {
            progress.value += 1
            if (progress.value >= 100) {
                pressAndHoldTimer.stop()
                progress.status = true
                progress.pressEnd()
            }
        }
    }

    onReleased: {
        pressAndHoldTimer.stop()
        relasedTimer.restart()
        if (!progress.status) {
            if (progress.value == 100) {
                console.log("released and mode on", progress.status)
                relasedTimer.stop()
            } else {
                progress.value -= 1
                if (progress.value <= 0) {
                    relasedTimer.stop()
                    progress.value = 0
                    console.log("released and mode on", progress.status)
                }
            }
        } else {
            if (progress.value == 0) {
                relasedTimer.stop()
                console.log("released1 and mode on", progress.status)
            } else {
                progress.value += 1
                if (progress.value >= 100) {
                    relasedTimer.stop()
                    progress.value = 100
                    console.log("released and mode on", progress.status)
                }
            }
        }
    }
}
