import QtQuick 2.0

Item {
    FontLoader {
        id: fontlcd
        source: "./DS-DIGI.TTF"
    }
    Text {
        id:lcdtimer
        color:"red"
        text: ""
        font.family: fontlcd.name
        font.pixelSize: 50
    }
}
