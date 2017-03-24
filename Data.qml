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
import QtQuick.Controls 1.0
import Data 1.0

Item {
    property alias testingInput: testingInput

    ListModel {
        id: testingInput
        //dynamicRoles: true
        ListElement{xPos: 0.0; yPos: 0.0; zPos: 0.0} // SET VALUES FROM VARIABLES THAT GET INCREMENTED IN INPUT SECTION BELOW

        // points 2-7 of aircraft view
        ListElement{xPos: 0.0; yPos: 0.0; zPos: 0.0} // 2
        ListElement{xPos: 0.0; yPos: 0.0; zPos: 0.0} // 3
        ListElement{xPos: 0.0; yPos: 0.0; zPos: 0.0} // 4
        ListElement{xPos: 0.0; yPos: 0.0; zPos: 0.0} // 5
        ListElement{xPos: 0.0; yPos: 0.0; zPos: 0.0} // 6
        ListElement{xPos: 0.0; yPos: 0.0; zPos: 0.0} // 7

    }

    // increment relevant coordinate value
   Text
   {
       anchors.centerIn: parent
       focus: true

       Keys.onPressed:
       {

           switch(event.key)
           {
           case Qt.Key_Semicolon: // RIGHT
               ++point1.xControl
               break;
           case Qt.Key_K: // LEFT
               --point1.xControl
               break;
           case Qt.Key_W: // UP
               ++point1.yControl
               break;
           case Qt.Key_S: // DOWN
               --point1.yControl
               break;
           case Qt.Key_O: // FORWARDS
               ++point1.zControl
               break;
           case Qt.Key_L: // BACKWARDS
               --point1.zControl
               break;
           /*case Qt.Key_A:  // YAW LEFT          inputs will be used in KI flight sim model
               ++point1.xControl
               break;
           case Qt.Key_D:  // YAW RIGHT
               ++point1.xControl
               break;*/

           case Qt.Key_Q:
               Qt.quit(0)
               break;
            }
       }
    }

   Timer {
       id: refreshTimer
       interval: 20
       running: true
       repeat: true
       onTriggered:
            {
           // update data every 20 ms
           point1.updateCoords();

           //update other points
           point2.updateOthers(point2.point, point1.xCoord, point1.yCoord, point1.zCoord);
           point3.updateOthers(point3.point, point1.xCoord, point1.yCoord, point1.zCoord);
           point4.updateOthers(point4.point, point1.xCoord, point1.yCoord, point1.zCoord);
           point5.updateOthers(point5.point, point1.xCoord, point1.yCoord, point1.zCoord);
           point6.updateOthers(point6.point, point1.xCoord, point1.yCoord, point1.zCoord);
           point7.updateOthers(point7.point, point1.xCoord, point1.yCoord, point1.zCoord);

           //console.log('xcoord = ',point1.xCoord);

           testingInput.setProperty(0,"xPos",point1.xCoord)
           testingInput.setProperty(0,"yPos",point1.yCoord)
           testingInput.setProperty(0,"zPos",point1.zCoord)

           // other points
           testingInput.setProperty(1,"xPos",point2.xCoord)
           testingInput.setProperty(2,"xPos",point3.xCoord)
           testingInput.setProperty(3,"xPos",point4.xCoord)
           testingInput.setProperty(4,"xPos",point5.xCoord)
           testingInput.setProperty(5,"xPos",point6.xCoord)
           testingInput.setProperty(6,"xPos",point7.xCoord)

           testingInput.setProperty(1,"yPos",point2.yCoord)
           testingInput.setProperty(2,"yPos",point3.yCoord)
           testingInput.setProperty(3,"yPos",point4.yCoord)
           testingInput.setProperty(4,"yPos",point5.yCoord)
           testingInput.setProperty(5,"yPos",point6.yCoord)
           testingInput.setProperty(6,"yPos",point7.yCoord)

           testingInput.setProperty(1,"zPos",point2.zCoord)
           testingInput.setProperty(2,"zPos",point3.zCoord)
           testingInput.setProperty(3,"zPos",point4.zCoord)
           testingInput.setProperty(4,"zPos",point5.zCoord)
           testingInput.setProperty(5,"zPos",point6.zCoord)
           testingInput.setProperty(6,"zPos",point7.zCoord)
           graphData.sync;

           }

       }

}

