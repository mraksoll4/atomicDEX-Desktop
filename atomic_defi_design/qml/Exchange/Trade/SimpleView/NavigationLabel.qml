//! Qt Imports
import QtQuick 2.15
//! 3rdParty Imports
import Qaterial 1.0 as Qaterial

import App 1.0

//! Project Imports
import "../../../Components"

DexLabel // Trade Tab
{
    id: control
    property var currentPage
    property var selectedPage
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.pixelSize: Constants.Style.textSize
    property bool checked: false
    signal clicked() 
    color: {

        if(control.currentPage === control.selectedPage) {
            DexTheme.backgroundDarkColor0
        } else {
            if(mouseArea.containsMouse) {
                DexTheme.accentColor
            } else {
                DexTheme.foregroundColor
            }
        }

        
        //? ? DexTheme.buttonColorEnabled : DexTheme.accentColor : currentSubPage === subPages.Trade ? DexTheme.buttonColorEnabled : DexTheme.foregroundColor  
    }
    DexMouseArea
    {
        id: mouseArea
        anchors.fill: parent
        onClicked: control.clicked()
        hoverEnabled: true
    }
}