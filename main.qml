/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Data Visualization module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.1
import QtQuick.Layouts 1.0
import QtDataVisualization 1.0
import "."
import QtQuick.Controls 1.1
import QtGamepad 1.0
import Data 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Plotting moving point in 3D space")

    Gamepad {
        id: gamepad1
        deviceId: GamepadManager.connectedGamepads.length > 0 ? GamepadManager.connectedGamepads[0] : -1
    }

    Connections {
        target: GamepadManager
        onGamepadConnected: gamepad1.deviceId = deviceId
    }

    GamepadKeyNavigation {
        id: gamepadKeyNavigation
        gamepad: gamepad1
        active: true
        buttonYKey: Qt.Key_Y
    }

    Data {
        id: graphData
    }

    Item {
        id: dataView
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height - buttonLayout.height

        //! [0] // get the data
        Scatter3D {
            //! [0]
            id: scatterGraph
            width: dataView.width
            height: dataView.height
            theme: Theme3D { type: Theme3D.ThemeStoneMoss } //ThemeDigia }
            shadowQuality: AbstractGraph3D.ShadowQualityNone


            //scene.activeCamera.yRotation: 10.0
            //! [1]
            inputHandler: null
            //! [1]

            axisX.min: -20
            axisY.min: -20
            axisZ.min: -20
            axisX.max: 20
            axisY.max: 20
            axisZ.max: 20

            Scatter3DSeries {
                id: scatterSeriesThree
                itemLabelFormat: "Three - X:@xLabel Y:@yLabel Z:@zLabel"
                mesh: Abstract3DSeries.MeshCube

                ItemModelScatterDataProxy {
                    itemModel: graphData.testingInput
                    xPosRole: "xPos"
                    yPosRole: "yPos"
                    zPosRole: "zPos"
                }
            }
        }

        DataProcessor {
            id: point1
            point: 1
            xCoord: 0
            yCoord: 0
            zCoord: 0
            xControl: 0
            yControl: 0
            zControl: 0
            cubeLength: 2

            t0: 0
            t1: 0.02
            dt: point1.t1-point1.t0
        }

        DataProcessor {
            id: point2
            point: 2
            xCoord: 0
            yCoord: 1*point1.cubeLength // SHOULD BE CUBE LENGTH!
            zCoord: 0
            xControl: 0
            yControl: 0
            zControl: 0
            cubeLength: point1.cubeLength
        }

        DataProcessor {
            id: point3
            point: 3
            xCoord: -1*point1.cubeLength
            yCoord: 0
            zCoord: 0
            xControl: 0
            yControl: 0
            zControl: 0
            cubeLength: point1.cubeLength
        }

        DataProcessor {
            id: point4
            point: 4
            xCoord: 1*point1.cubeLength
            yCoord: 0
            zCoord: 0
            cubeLength: point1.cubeLength
        }

        DataProcessor {
            id: point5
            point: 5
            xCoord: 0
            yCoord: 0
            zCoord: 1*point1.cubeLength
            cubeLength: point1.cubeLength
        }

        DataProcessor {
            id: point6
            point: 6
            xCoord: 0
            yCoord: 0
            zCoord: 2*point1.cubeLength
            cubeLength: point1.cubeLength
        }

        DataProcessor {
            id: point7
            point: 7
            xCoord: 0
            yCoord: 0
            zCoord: 3*point1.cubeLength
            cubeLength: point1.cubeLength
        }

        //! [2]
        MouseArea {
            id: inputArea
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            property int mouseX: -1
            property int mouseY: -1
            //! [2]

            //! [3]
            onPositionChanged: {
                mouseX = mouse.x;
                mouseY = mouse.y;
            }
            //! [3]

            //! [5]
            onWheel: {
                // Adjust zoom level based on what zoom range we're in.
                var zoomLevel = scatterGraph.scene.activeCamera.zoomLevel;
                if (zoomLevel > 100)
                    zoomLevel += wheel.angleDelta.y / 12.0;
                else if (zoomLevel > 50)
                    zoomLevel += wheel.angleDelta.y / 60.0;
                else
                    zoomLevel += wheel.angleDelta.y / 120.0;
                if (zoomLevel > 500)
                    zoomLevel = 500;
                else if (zoomLevel < 10)
                    zoomLevel = 10;

                scatterGraph.scene.activeCamera.zoomLevel = zoomLevel;
            }
            //! [5]
        }

        //! [4]
        Timer {
            id: reselectTimer
            interval: 10
            running: true
            repeat: true
            onTriggered: {
                scatterGraph.scene.selectionQueryPosition = Qt.point(inputArea.mouseX, inputArea.mouseY);
                graphData.sync; // Sync data every 10 ms


            }
        }
        //! [4]
    }

// get good angle of graph view
//------------------------------------------------------- NEED TO DO THIS


   //STOPS THE SPINNING
    //! [6]
    NumberAnimation {
        id: cameraAnimationX
        loops: Animation.Infinite
        running: true
        target: scatterGraph.scene.activeCamera
        property:"xRotation"
        from: 0.0
        to: 360.0
        duration: 20000
    }
    //! [6]


    //! [7]
    SequentialAnimation {
        id: cameraAnimationY
        loops: Animation.Infinite
        running: true

        NumberAnimation {
            target: scatterGraph.scene.activeCamera
            property:"yRotation"
            from: 5.0
            to: 45.0
            duration: 9000
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            target: scatterGraph.scene.activeCamera
            property:"yRotation"
            from: 45.0
            to: 5.0
            duration: 9000
            easing.type: Easing.InOutSine
        }
    }
    //! [7]

 //ENDS HERE
    RowLayout {
        id: buttonLayout
        Layout.minimumHeight: shadowToggle.height
        width: parent.width
        anchors.left: parent.left
        spacing: 0

        NewButton {
            id: shadowToggle
            Layout.fillHeight: true
            Layout.minimumWidth: parent.width / 3 // 3 buttons divided equally in the layout
            text: scatterGraph.shadowsSupported ? "Hide Shadows" : "Shadows not supported"
            enabled: scatterGraph.shadowsSupported

            onClicked: {
                if (scatterGraph.shadowQuality === AbstractGraph3D.ShadowQualityNone) {
                    scatterGraph.shadowQuality = AbstractGraph3D.ShadowQualityMedium;
                    text = "Hide Shadows";
                } else {
                    scatterGraph.shadowQuality = AbstractGraph3D.ShadowQualityNone;
                    text = "Show Shadows";
                }
            }
        }

        NewButton {
            id: cameraToggle
            Layout.fillHeight: true
            Layout.minimumWidth: parent.width / 3
            text: "Pause Camera"

            onClicked: {
                cameraAnimationX.paused = !cameraAnimationX.paused;
                cameraAnimationY.paused = cameraAnimationX.paused;
                if (cameraAnimationX.paused) {
                    text = "Animate Camera";
                } else {
                    text = "Pause Camera";
                }
}

        }

        NewButton {
            id: exitButton
            Layout.fillHeight: true
            Layout.minimumWidth: parent.width / 3
            text: "Quit"
            onClicked: Qt.quit(0);
        }
    }
}
//}
