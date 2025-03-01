import QtQuick 2.15
import QtQuick.Controls 2.15
import Qaterial 1.0 as Qaterial
import QtQuick.Layouts 1.5

import App 1.0

Item {
    id: control
    width: 200
    height: 35

    property int leftWidth: -1
    property int max_length: 180

    property alias value: input_field.text

    property alias field: input_field
    property alias background: _background

    property string leftText: ""
    property string rightText: ""
    property string placeholderText: ""

    property bool error: false
    onErrorChanged: {
        if (error) {
            _animationTimer.start()
            _animate.start()
        }
    }
    Timer {
        id: _animationTimer
        interval: 350
        onTriggered: {
            _animate.stop()
            _background.x = 0
        }
    }
    Timer {
        id: _animate
        interval: 30
        repeat: true
        onTriggered: {
            if (_background.x == -3) {
                _background.x = 3
            } else {
                _background.x = -3
            }
        }
    }

    function reset() {
        input_field.text = ""
    }
    Rectangle {
        id: _background
        width: parent.width
        height: parent.height
        radius: 4
        color: DexTheme.surfaceColor
        border.color: control.error ? DexTheme.redColor : input_field.focus ? DexTheme.accentColor : DexTheme.rectangleBorderColor
        border.width: input_field.focus ? 1 : 0
        Behavior on x {
            NumberAnimation {
                duration: 40
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        spacing: 2
        Item {
            visible: leftText !== ""
            Layout.preferredWidth: leftWidth !== -1 ? leftWidth : _title_label.implicitWidth + 2
            Layout.fillHeight: true
            DexLabel {
                id: _title_label
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 5
                horizontalAlignment: DexLabel.AlignHCenter
                text: leftText
                color: DexTheme.foregroundColor
                opacity: .4
                font.pixelSize: 14
                font.weight: Font.Medium
            }
        }
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                radius: _background.radius
                color: DexTheme.surfaceColor
                DexTextField {
                    id: input_field
                    onTextChanged: {
                        if (text.length > control.max_length) {
                            console.log("too long! ", text.length)
                            text = text.substring(0, control.max_length)
                        }
                        control.error = false
                    }
                    horizontalAlignment: Qt.AlignLeft
                    echoMode: TextInput.Normal
                    background: Item {}
                    font.weight: Font.Medium
                    font.family: 'Lato'
                    font.pixelSize: 13
                    anchors.fill: parent
                }
                DexLabel {
                    text: control.placeholderText
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: input_field.leftPadding
                    color: DexTheme.foregroundColor
                    font: DexTypo.body1
                    elide: DexLabel.ElideRight
                    width: parent.width - 10
                    wrapMode: DexLabel.NoWrap
                    visible: input_field.text === ""
                    opacity: .2
                }
            }
        }
        Item {
            visible: rightText !== ""
            Layout.preferredWidth: _suffix_label.implicitWidth + 2
            Layout.fillHeight: true
            DexLabel {
                id: _suffix_label
                anchors.centerIn: parent
                horizontalAlignment: DexLabel.AlignHCenter
                text: rightText
                color: DexTheme.foregroundColor
                opacity: .4
                font.pixelSize: 14
                font.weight: Font.Medium
            }
        }
    }
}