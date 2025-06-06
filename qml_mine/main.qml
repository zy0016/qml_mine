import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import "minegame.js" as MineGame

ApplicationWindow   {
    id: root
    visible: true
    width: 345
    height: 450
    title: qsTr("mine")
    property int initTime: 0

    // 在 QML 中监听 C++ 类的信号
    Component.onCompleted: {
        myClass.messageChanged.connect(onMessageChanged);
    }
    // 处理信号的槽
    function onMessageChanged(message) {
        // 输出 JSON 格式的消息
        console.log("Received JSON message:", message);
        console.log("Time:", message.timer);
        timename.text = message.timer;
    }

    Rectangle {
        id:myrect
        anchors.fill: parent
        color:"white"
    }
    //flags: Qt.WindowCloseButtonHint|Qt.WindowMinimizeButtonHint
    //Grid {
        LcdTimer {
            id:lcdtime
            Text {
                id: timename
                text: qsTr("0")
                font.pixelSize: 50
            }
            anchors {
                left:parent.left
                top:parent.top }
        }

        Button {
            id: newGameButton
            width :50
            height:50
            property string frontImage: "qrc:/s1.png"
            property string backImage: "qrc:/s2.png"
            property bool isFront: true  // 当前显示的是否为正面图片

            icon.width:50
            icon.height: 50
            icon.source: "qrc:/s1.png"
            icon.color: Material.color(Material.Red)
            anchors {
                horizontalCenter: parent.horizontalCenter
                top:parent.top}

            onClicked: {
                console.log("newGameButton click!");
                console.log("rotationAnimation " + rotationAnimation);
                //console.log("rotationAnimation.from " + rotationAnimation.from);
                //console.log("rotationAnimation.to " + rotationAnimation.to);
                if (!rotationAnimation.running) {
                        rotationAnimation.start();
                    }
            }
            /*Image {
                    id: frontImageView
                    source: newGameButton.frontImage
                    fillMode: Image.Stretch
                    anchors.fill: parent
                    smooth: true
                    opacity: newGameButton.isFront ? 1 : 0
                    transform: Rotation {
                        origin.x: parent.width / 2
                        origin.y: parent.height / 2
                        axis { x: 0; y: 1; z: 0 }
                        angle: newGameButton.isFront ? rotationAnimation.from : rotationAnimation.to
                    }
                }

                Image {
                    id: backImageView
                    source: newGameButton.backImage
                    fillMode: Image.Stretch
                    anchors.fill: parent
                    smooth: true
                    opacity: newGameButton.isFront ? 0 : 1
                    transform: Rotation {
                        origin.x: parent.width / 2
                        origin.y: parent.height / 2
                        axis { x: 0; y: 1; z: 0 }
                        angle: newGameButton.isFront ? rotationAnimation.to : rotationAnimation.from
                    }
                }
                SequentialAnimation {
                        id: rotationAnimation
                        running: false
                        loops: 1

                        NumberAnimation {
                            target: frontImageView.transform[0]
                            property: "angle"
                            from: 0
                            to: 90
                            duration: 250
                            easing.type: Easing.InCubic
                        }

                        ScriptAction {
                            script: {
                                newGameButton.isFront = !newGameButton.isFront;
                                console.log("ScriptAction newGameButton.isFront:" + newGameButton.isFront);
                            }
                        }

                        NumberAnimation {
                            target: backImageView.transform[0]
                            property: "angle"
                            from: 90
                            to: 0
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }*/
        }
        LcdMineNum {
            x:280
            y:0
            width :50
            height:50
            id:lcdmine
            Text {
                id: minename
                text: qsTr("10")
                font.pixelSize: 50
            }
            anchors {
                //right:parent.right
                //horizontalAlignment:Qt.AlignRight
                //horizontalCenter:Qt.AlignRight
                //right:parent.TopRight
                top:parent.top
            }
        }
        Timer{
                id:timer_1
                interval: 1000
                repeat: true
                triggeredOnStart: true //start()时触发
                onTriggered: {//触发器
                    initTime++
                    timename.text = initTime
                }
            }


        Canvas {
            id: maincanvas
            x:0
            y:60
            width:360
            height: 440
            property var imagered :Image {
                id: img_red;
                width:30;
                height: 30;
                source: "qrc:/redmine.png"}
            property var imageblack :Image {
                id: img_black;
                width:30;
                height: 30;
                source: "qrc:/blackmine.png"}
            property var imageinterrogation :Image {
                id: img_interrogation;
                width:30;
                height: 30;
                source: "qrc:/interrogation.png"}
            property var imageflag :Image {
                id: img_flag;
                width:30;
                height: 30;
                source: "qrc:/flag.png"}
            property var image0 :Image {
                            id: img_t0;
                            width:30;
                            height: 30;
                            source: "qrc:/t0.png"}
            property var image1 :Image {
                            id: img_t1;
                            width:30;
                            height: 30;
                            source: "qrc:/t1.png"}
            property var image2 :Image {
                            id: img_t2;
                            width:30;
                            height: 30;
                            source: "qrc:/t2.png"}
            property var image3 :Image {
                            id: img_t3;
                            width:30;
                            height: 30;
                            source: "qrc:/t3.png"}
            property var image4 :Image {
                            id: img_t4;
                            width:30;
                            height: 30;
                            source: "qrc:/t4.png"}
            property var image5 :Image {
                            id: img_t5;
                            width:30;
                            height: 30;
                            source: "qrc:/t5.png"}
            property var image6 :Image {
                            id: img_t6;
                            width:30;
                            height: 30;
                            source: "qrc:/t6.png"}
            property var image7 :Image {
                            id: img_t7;
                            width:30;
                            height: 30;
                            source: "qrc:/t7.png"}
            property var image8 :Image {
                            id: img_t8;
                            width:30;
                            height: 30;
                            source: "qrc:/t8.png"}
            MouseArea{
                anchors.fill:parent
                acceptedButtons: Qt.LeftButton|Qt.RightButton;
                onClicked: (mouse) => {
                    var sChessmine = MineGame.getChessmanValue();
                    var chessnum = MineGame.getChessnum();
                    var hx1 = MineGame.getHx1();
                    var hy1 = MineGame.getHy1();
                    var bh = MineGame.getBh();
                    var bw = MineGame.getBw();
                    if ((mouseX < hx1) || (mouseX > hx1 + bw * chessnum))
                       return false;
                    if ((mouseY < hy1) || (mouseY > hy1 + bh * chessnum))
                       return false;
                    var position = MineGame.getChessNumber(mouseX,mouseY);
                    var irow = position[0];
                    var icol = position[1];
                    if (MineGame.ifGameOver())
                    {
                        MineGame.mineOver();
                        return true;
                    }
                    //MineGame.beginMine();
                    //timer_1.start();
                    myClass.startTimer();
                    if (mouse.button === Qt.LeftButton)
                    {
                        var bminetype = sChessmine[irow][icol].getMinetype();
                        if (sChessmine[irow][icol].bMineType)//people click the mine,game over
                        {
                            //display all mines and display game over.
                            sChessmine[irow][icol].setGridtype(4);
                            MineGame.setGamedefeat(true);
                            MineGame.setGameResult(1);
                            //timer_1.stop();
                            myClass.stopTimer();
                            messageDialogFail.open();
                            newGameButton.icon.source = "qrc:/s2.png"
                            //newGameButton.rotationAnimation.start();
                        }
                        else
                        {
                            if (sChessmine[irow][icol].eGridType !== 0)
                               return;
                            if (sChessmine[irow][icol].iMineNum === 0)
                            {
                               MineGame.setMines(irow,icol);
                            }
                            else
                            {
                               sChessmine[irow][icol].setGridtype(3);
                            }
                            if (MineGame.ifGameOver())
                            {
                               MineGame.setGameResult(0);
                               messageDialogSuccess.open();
                               //timer_1.stop();
                               myClass.stopTimer();
                            }
                        }
                    }
                    else if(mouse.button === Qt.RightButton)
                    {
                        if (sChessmine[irow][icol].eGridType === 0)
                        {
                            sChessmine[irow][icol].setGridtype(1);
                            var iminenum = MineGame.setMineNumber(1);
                            minename.text = iminenum;
                            if (MineGame.ifGameOver())
                            {
                                MineGame.setGameResult(0);
                                messageDialogSuccess.open();
                                //timer_1.stop();
                                myClass.stopTimer();
                            }
                        }
                        else if (sChessmine[irow][icol].eGridType === 1)
                        {
                            sChessmine[irow][icol].setGridtype(2);
                            var iminenum2 = MineGame.setMineNumber(-1);
                            minename.text = iminenum2;
                        }
                        else if (sChessmine[irow][icol].eGridType === 2)
                        {
                            sChessmine[irow][icol].setGridtype(0);
                        }
                    }
                    maincanvas.requestPaint();
                }
            }
            onPaint: {
                var chessnum = MineGame.getChessnum();
                var iLinenum = (chessnum + 1) * 2;
                var hx1 = MineGame.getHx1();
                var hy1 = MineGame.getHy1();
                var bh = MineGame.getBh();
                var bw = MineGame.getBw();
                var minenum = MineGame.getMinenum();
                var i;
                var j;
                var iPicWidth = 30;
                var iPicHeight = 30;
                var bMineDefeat = MineGame.getGamedefeat();
                var ctx = getContext("2d");
                ctx.reset();
                minename.text = MineGame.getRemainMinenum();
                if (!MineGame.getChessInitedValue()){
                    MineGame.initChessman(0)
                }
                var sChessmine = MineGame.getChessmanValue();
                /*ctx.lineWidth = 2
                ctx.strokeStyle = "red"
                ctx.fillStyle = "blue"
                ctx.beginPath()
                ctx.rect(100, 80, 120, 80)
                ctx.fill()
                ctx.stroke()*/
                //ctx.strokeStyle = "grey"
                ctx.lineWidth = 1
                ctx.beginPath();
                for (i = 0;i < iLinenum;i++)
                {
                    if (i < iLinenum / 2)
                    {
                        //ctx.moveTo(hx1,hy1 + bh * i);
                        //ctx.lineTo(hx1 + bw * chessnum,hy1 + bh * i);
                    }
                    else
                    {
                        //ctx.moveTo(hx1 + bw * (i - iLinenum / 2),hy1);
                        //ctx.lineTo(hx1 + bw * (i - iLinenum / 2),hy1 + bh * chessnum);
                    }
                }
                for (i = 0;i < chessnum;i++)
                {
                    for (j = 0;j < chessnum;j++)
                    {
                        if (bMineDefeat)//defeat,display all mines
                        {
                            if (sChessmine[i][j].eGridType === 4)//display the defeat mine
                            {
                                ctx.drawImage(imagered,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                            }
                            else
                            {
                                if (sChessmine[i][j].bMineType)
                                {
                                    ctx.drawImage(imageblack,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                }
                                else
                                {
                                    //ctx.text(sChessmine[i][j].iMineNum,sChessmine[i][j].x + bw / 2 - 5,sChessmine[i][j].y + bh / 2 + 4);
                                    switch(sChessmine[i][j].iMineNum)
                                    {
                                    case 0:
                                        ctx.drawImage(image0,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 1:
                                        ctx.drawImage(image1,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 2:
                                        ctx.drawImage(image2,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 3:
                                        ctx.drawImage(image3,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 4:
                                        ctx.drawImage(image4,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 5:
                                        ctx.drawImage(image5,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 6:
                                        ctx.drawImage(image6,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 7:
                                        ctx.drawImage(image7,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 8:
                                        ctx.drawImage(image8,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    }
                                }
                            }
                        }
                        else
                        {
                            switch(sChessmine[i][j].eGridType)
                            {
                            case 0://normal
                                ctx.fillStyle = "grey";
                                ctx.beginPath();
                                ctx.rect(sChessmine[i][j].x + 1,sChessmine[i][j].y + 1,bw - 1,bh - 1);
                                ctx.fill();
                                break;
                            case 1://flag
                                ctx.fillStyle = "grey";
                                ctx.beginPath();
                                ctx.rect(sChessmine[i][j].x,sChessmine[i][j].y,bw - 1,bh - 1);
                                ctx.fill();
                                ctx.drawImage(imageflag,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                break;
                            case 2://interrogation
                                ctx.fillStyle = "grey";
                                ctx.beginPath();
                                ctx.rect(sChessmine[i][j].x,sChessmine[i][j].y,bw - 1,bh - 1);
                                ctx.fill();
                                ctx.drawImage(imageinterrogation,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                break;
                            case 3://click open
                                if (sChessmine[i][j].iMineNum !== 0)//display the number of the grid
                                {
                                    //ctx.text(sChessmine[i][j].iMineNum,sChessmine[i][j].x + bw / 2 - 5,sChessmine[i][j].y + bh / 2 + 4);
                                    switch(sChessmine[i][j].iMineNum)
                                    {
                                    case 0:
                                        ctx.drawImage(image0,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 1:
                                        ctx.drawImage(image1,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 2:
                                        ctx.drawImage(image2,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 3:
                                        ctx.drawImage(image3,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 4:
                                        ctx.drawImage(image4,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 5:
                                        ctx.drawImage(image5,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 6:
                                        ctx.drawImage(image6,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 7:
                                        ctx.drawImage(image7,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    case 8:
                                        ctx.drawImage(image8,sChessmine[i][j].x + (bw - iPicWidth) / 2,sChessmine[i][j].y + (bh - iPicHeight) / 2);
                                        break;
                                    }
                                }
                                else
                                {
                                    ctx.fillStyle = "silver";
                                    ctx.beginPath();
                                    ctx.rect(sChessmine[i][j].x,sChessmine[i][j].y,bw - 1,bh - 1);
                                    ctx.fill();
                                }
                                break;
                            case 4:
                                break;
                            }
                        }
                    }
                }
                ctx.stroke();
            }
        }
    //}
    menuBar: MenuBar {
            Menu {
                title: qsTr("&File")
                Action {
                         id:easy
                         text: qsTr("&Easy")
                         onTriggered: {
                             width=345; height=450;lcdmine.x=280;
                             MineGame.setChessLevel(0);
                             MineGame.initChessman(0);
                             timename.text = 0;
                             initTime = 0;
                             maincanvas.width = 360;
                             maincanvas.height = 440;
                             newGameButton.icon.source = "qrc:/s1.png";
                             maincanvas.requestPaint();
                         }
                }
                Action { text: qsTr("&Middle")
                         onTriggered: {
                             width=425; height=520;lcdmine.x=350;
                             MineGame.setChessLevel(1);
                             MineGame.initChessman(1);
                             timename.text = 0;
                             initTime = 0;
                             maincanvas.width = 520;
                             maincanvas.height = 590;
                             newGameButton.icon.source = "qrc:/s1.png";
                             maincanvas.requestPaint();
                         }}
                Action { text: qsTr("&hard")
                         onTriggered: {
                         width=505; height=595;lcdmine.x=430;
                         MineGame.setChessLevel(2);
                         MineGame.initChessman(2);
                         timename.text = 0;
                         initTime = 0;
                         maincanvas.width = 650;
                         maincanvas.height = 710;
                         newGameButton.icon.source = "qrc:/s1.png";
                         maincanvas.requestPaint();
                         }}
                Action { text: ("中文")
                         onTriggered: {
                         var i = qmlLanguage.getLocalLanguage();
                         console.log("Action Chinese " + i);
                         qmlLanguage.setLanguage(1)
                         }
                }
                Action { text: ("English")
                         onTriggered: {
                         var i = qmlLanguage.getLocalLanguage();
                         console.log("Action English " + i);
                         qmlLanguage.setLanguage(0)
                        }
                }
                Action { text: qsTr("&About")
                         onTriggered:messageDialog.open(); }
                MenuSeparator { }
                Action { text: qsTr("&Quit")
                         onTriggered: close()}
            }
        }
    MessageDialog {
                id: messageDialog
                title:qsTr("about mine")
                icon: StandardIcon.Information
                text: qsTr("1.0 version Copyright 03-28-2025 zhaoyong")
                onAccepted: {
                    console.log("And of course you could only agree.")
                }
            }
    MessageDialog {
                id: messageDialogSuccess
                title:qsTr("about mine")
                icon: StandardIcon.Information
                text: qsTr("You Win!")
                onAccepted: {
                    console.log("And of course you could only agree.")
                }
            }
    MessageDialog {
                id: messageDialogFail
                title:qsTr("about mine")
                icon: StandardIcon.Critical
                text: qsTr("You Lost!")
                onAccepted: {
                    console.log("And of course you could only agree.")
                }
            }
}
