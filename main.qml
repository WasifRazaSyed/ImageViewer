import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
import QtQuick.Dialogs

import com.company.ImageFinder

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Image Viewer")

    property var noImg: ({})
    property var myIcon: ({})
    property int i: 0
    property int items: 0
    property var imgPath;
    Action
    {
        id: openImg
        text: qsTr("Open")
        icon.color: "transparent"
        icon.source: "qrc:/ico/icons8-open-30.png"
        onTriggered:
        {
            fileOpener.open()
        }
    }

    ImgInDir
    {
        id: cppCode
    }

    FileDialog
    {
        id: fileOpener
        title: "Please choose a file"
        fileMode: FileDialog.OpenFile
        currentFolder: cppCode.folder()
        nameFilters: ["Images (*.JPEG *jpg *png *svg *webp)"]
        onAccepted:
        {
            if(i==0)
            {
                noImg.visible=false
                stackView.pop()
                stackView.push(myIcon)
                i++
            }

            items=cppCode.setFolder(currentFolder)
            cppCode.detectIndex(selectedFile);
            myIcon.img.source=selectedFile
            currentFolder=cppCode.folder()

            zoomIn.opacity=1;
            zoomOut.opacity=1;
            full.opacity=1;
            zoomIn.enabled=true;
            zoomOut.enabled=true;
            full.enabled=true;

            if(items==1)
            {
                goRight.opacity=1;
                goLeft.opacity=1;
                goRight.enabled=true;
                goLeft.enabled=true;
            }
            else
            {
                goRight.enabled=false;
                goLeft.enabled=false;
                goRight.opacity=0.5;
                goLeft.opacity=0.5;
            }
        }
    }

    Rectangle
    {
        id: toolbar
        color: "silver"
        width: parent.width
        height: 30
        z:5

        ToolButton
        {
            action: openImg
        }

        Row
        {
            anchors.centerIn: parent
            spacing: 5

            MyIcon
            {
                id: zoomOut
                img.source: "qrc:/ico/icons8-zoom-out-30.png"
                area.onClicked:
                {
                    myIcon.img.scale=0.5
                    myIcon.anchors.centerIn=myIcon.parent
                    myIcon.imgArea.enabled=false
                }
            }

            MyIcon
            {
                id: zoomIn
                img.source: "qrc:/ico/icons8-zoom-in-30.png"
                area.onClicked:
                {
                    myIcon.anchors.centerIn=null
                    myIcon.img.scale++
                    myIcon.imgArea.enabled=true
                }

            }
            MyIcon
            {
                id: full
                img.source: "qrc:/ico/icons8-full-screen-30.png"
                area.onClicked:
                {
                    myIcon.img.scale=1
                    myIcon.anchors.centerIn=myIcon.parent
                    myIcon.imgArea.enabled=false
                }

            }
        }
    }
    Rectangle
    {
        id: imgContainer
        width: parent.width
        height: parent.height-toolbar.height
        anchors.top: toolbar.bottom
        clip: true

        Component.onCompleted:
        {
            noImg=Qt.createQmlObject(
                        'import QtQuick 2.15; import QtQuick.Controls; Text { id: noImgText;
                text: qsTr("Welcome to Image Viewer. Open a folder to see the photos.");
                anchors.centerIn: parent;
                color: "black";
                visible: true
                Component.onCompleted:
                {
                    goRight.opacity=0.5;
                    goLeft.opacity=0.5;
                    zoomIn.opacity=0.5;
                    zoomOut.opacity=0.5;
                    full.opacity=0.5;
                    goRight.enabled=false;
                    goLeft.enabled=false;
                    zoomIn.enabled=false;
                    zoomOut.enabled=false;
                    full.enabled=false;
                }
            }', stackView,"WelcomeText");

            myIcon=Qt.createQmlObject(
                        'import QtQuick 2.15; import QtQuick.Window 2.15; import QtQuick.Controls; import QtQuick.Dialogs;
            MyIcon
            {
                id: mainImg;
                width: imgContainer.width;
                height: imgContainer.height;
                area.enabled: false;
                visible: false;
                imgArea.drag.target: mainImg;
                imgArea.drag.maximumY: 175;
                imgArea.drag.minimumY: -(175);

                imgArea.drag.maximumX: root.width/2;
                imgArea.drag.minimumX: -(root.width/2);
            }   ',stackView, "ImgComponent");
        }

        MyIcon
        {
            id: goRight
            img.source: "qrc:/ico/icons8-right-arrow-30.png"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            area.onClicked:
            {
                imgPath=cppCode.forward()
                myIcon.img.source=imgPath
            }
            z: 2
        }
        MyIcon
        {
            id: goLeft
            img.source: "qrc:/ico/icons8-left-arrow-30.png"
            anchors.right: root.Right
            anchors.verticalCenter: parent.verticalCenter
            area.onClicked:
            {
                imgPath=cppCode.backward()
                myIcon.img.source=imgPath
            }
            z: 2
        }

        StackView
        {
            id: stackView
            width: imgContainer.width
            height: imgContainer.height
            initialItem: noImg
        }
    }
}

