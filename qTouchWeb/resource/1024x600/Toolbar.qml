import Qt 4.7

Rectangle {
    id: toolbar
    height: 58
//    color: "#C6C8D1"

    signal reloadClicked();
    signal stopClicked();
    signal backClicked();
    signal forwardClicked();
    signal optionsClicked();

    property bool loading : false
    property real progress : 0.0
    property string url : textInput.text
    property string url_restore : url

    onLoadingChanged: {
        textInput.focus = false; // escape focus

//        if (loading)
//            reload.source = ":images/bt_browser_stop.png";
//        else
//            reload.source = ":images/bt_browser_reload.png";
    }

//    onUrlChanged: { // should consider button item or state changes while textInput.focus
//        reload.source = ":images/bt_browser_clear.png";
//    }

    function setUrl(value) {
         if (value.length <= 60) textInput.text = value;
        else textInput.text = value.substring(0, 57) + '...';
    }

    BorderImage {
        source: ":images/toolbar.png"
        anchors.top: parent.top 
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalTileMode: BorderImage.Repeat
    }

    Image {
        id: back
        source: ":images/back.png"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.topMargin: -10;
        //anchors.margins: 10;
        MouseArea {
            anchors.fill: parent
            onClicked: toolbar.backClicked();
        }
    }

    Image {
        id: forward
        source: ":images/forward.png"
        anchors.left: back.right
        anchors.verticalCenter: parent.verticalCenter
        //anchors.margins: 10;
        //anchors.leftMargin: 12;
        MouseArea {
            anchors.fill: parent
            onClicked: toolbar.forwardClicked();
        }
    }

    Image {
        id: options
        source: ":images/tab.png"
        anchors.left: forward.right
        anchors.verticalCenter: parent.verticalCenter
        //anchors.margins: 10;
        //anchors.leftMargin: 7;
        MouseArea {
            anchors.fill: parent
            onClicked: toolbar.optionsClicked();
        }
    }

    Image {
        id: bookmark
        source: ":images/bookmark.png"
        anchors.left: options.right
        opacity: 0.3
        //anchors.rightMargin: 12;
        //anchors.leftMargin: 16;
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: add
        source: ":images/add.png"
        anchors.left: bookmark.right
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.3
        //anchors.margins: 10
        MouseArea {
            anchors.fill: parent
            //onPressed: add.source = ":images/bt_browser_bookmark.png"
            //onReleased: add.source = ":images/bt_browser_add.png"
        }
    }

    BorderImage {
        id: input
        source: ":images/inputtext.png"
        anchors.left: add.right
        anchors.right: parent.right
        //anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top;

        anchors.topMargin: 20;
        anchors.rightMargin: 20;
        //anchors.leftMargin: 15;

        border.left: 15;
        border.right: 15;

        BorderImage {
            source: ":images/inputtext_progress.png"
            /* XXX: use clip in the future when clip bug is fixed */
            width: {  
                if (toolbar.progress != 1) Math.max(20, input.width * toolbar.progress)
                else 0 // clean up progress bar once loaded
            }
            border.left: 10;
            border.right: 10;
            visible: (width > 20);
        }

        TextInput {
            id: textInput
            text: ""
            color: "black"
            anchors.fill: parent
            anchors.margins: 6
            font.family: "Nokia Sans"
            font.pixelSize: 16 
            onAccepted: {
                url_restore = url;
                toolbar.reloadClicked();
            }
        }

        Image {
            id: reload
            source: ":images/bt_browser_reload.png"
            anchors.right: textInput.right
            anchors.verticalCenter: parent.verticalCenter
            visible: !toolbar.loading && !textInput.focus
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // FIXME resume url if empty
                    toolbar.setUrl(url_restore);
                    toolbar.reloadClicked();
                }
            }
        }

        Image {
            id: stop
            source: ":images/bt_browser_stop.png"
            anchors.right: textInput.right
            anchors.verticalCenter: parent.verticalCenter
            visible: toolbar.loading && !textInput.focus
            MouseArea {
                anchors.fill: parent
                onClicked: toolbar.stopClicked();
            }
        }

        Image {
            id: clear
            source: ":images/bt_browser_clear.png"
            anchors.right: textInput.right
            anchors.verticalCenter: parent.verticalCenter
            visible: textInput.focus && url != '';
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    url_restore = url;
                    toolbar.setUrl('');
                }
            }
        }

    }

/*
    BorderImage {
        id: shadow
        source: ":images/shadow.png"
        anchors.top: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalTileMode: BorderImage.Repeat
    }
*/

}
