import Felgo 4.0
import QtQuick 2.0

Item {
  id: topBar
  height: 50

  // add background
  Image {
    anchors.fill: parent
    source: Qt.resolvedUrl("../assets/BGTopBar.png")
  }

  // add logo
  Image {
    width: 150
    height: 50
    anchors.top: parent.top
//    anchors.right: parent.right
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.topMargin: 2
//    anchors.rightMargin: 13
    source: Qt.resolvedUrl("../assets/Logo.png")
  }

  // add gold image (credits)
  Image {
    id: goldImage
    width: 36
    height: 30
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.topMargin: 8
    anchors.rightMargin: 4
    source: Qt.resolvedUrl("../assets/Coins.png")
  }

  // add gold amount (credit amount)
  Text {
    anchors.verticalCenter: goldImage.verticalCenter
    anchors.right: goldImage.left
    text: scene.creditAmount
    color: "white"
    font.pixelSize: 12
  }
}
