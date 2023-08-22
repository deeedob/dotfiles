import QtQuick.Controls

ApplicationWindow {
    id: root
    width: 640
    height: 480
    title: qsTr("Hello World")
    visible: true

    Button {
        id: button
        text: qsTr("Hello World")
        anchors.centerIn: parent
        onClicked: {
            console.log("Hello World")
        }
    }
}
