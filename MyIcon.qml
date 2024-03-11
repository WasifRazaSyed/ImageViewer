import QtQuick 2.15
import "script.js" as JS
Item {
    id: root
    property alias img: icon
    property alias area: icoArea
    property alias imgArea: imgArea_
    width: 30
    height: 30

    Image
    {
        id: icon
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        MouseArea
        {
            id: imgArea_
            anchors.fill: icon
            hoverEnabled: true
            enabled: false
        }
    }

    MouseArea
    {
        id: icoArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: icon.scale= 1.2
        onExited: icon.scale= 1.0
        onPressed: icon.scale= 1.0
        onReleased: JS.ifHovered(root)
    }
}
