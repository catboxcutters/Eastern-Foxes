import Felgo 4.0
import QtQuick 2.0
import "slotmachine"

GameWindow {
  id: gameWindow

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  activeScene: scene

  // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
  // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
  // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
  // this resolution is for iPhone 4 & iPhone 4S
  screenWidth: 960
  screenHeight: 640

  Scene {
    id: scene

    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 480
    height: 320
    Keys.onEnterPressed: {
        scene.startSlotMachine()
        console.log("enter pressed")
    }
    Keys.onSpacePressed: {
        scene.startSlotMachine()
        console.log("space pressed")
    }

    // properties for the game
    property int betAmount: 1 // amount to bet per line
    property int creditAmount: 50   // player credit for gambling
//    Keys.forwardTo: keyboardController
//    Item {
//          id: keyboardController

//          Keys.onPressed: {
//            if (event.key === Qt.Key_Left && moveRelease.running === false) {
//              event.accepted = true
//              moveRelease.start()
//              console.log("move Left")
//            }
//          }
    // animate credit amount when changed
    Behavior on creditAmount {
      PropertyAnimation { duration: scene.betAmount * 50 }
    }

    // fill game window with background
    Rectangle {
      anchors.fill: scene.gameWindowAnchorItem
      color: "#1c1818"
    }
    GameSoundEffect {
        id: spinsound

    }

    // add slot machine
    FlaskOfRumMachine {
      id: slotMachine

      // we center it horzizontally and move it 10 px "under" the top bar
      // because the image of the bar casts a shadow on on the slot machine
      anchors.horizontalCenter: scene.horizontalCenter
      anchors.top: topBar.bottom
      anchors.topMargin: -10

      // we want the slot machine to auto-size depending on the available height
      // the slotmachine will use the game window height except for the topBar and bottomBar area
      // like with the top bar, the bottom bar also casts a shadow on the to slot machine
      height: scene.gameWindowAnchorItem.height - (topBar.height + anchors.topMargin) - (bottomBar.height - 10)

      // we then calculate the default item height based on the actual slotmachine height and row count
      defaultItemHeight: Math.round(slotMachine.height / slotMachine.rowCount)

      // and change the reel width to match the item height (to maintain the width/height ratio of the items)
      defaultReelWidth: Math.round(defaultItemHeight / 80 * 67)

      // velocity of spin should decrease/increase along with item height
      spinVelocity: Math.round(defaultItemHeight / 80 * 750)

      // link signal to handler function
      onSpinEnded: scene.spinEnded()

      // choose random delay to stop each reel for every spin
      onSpinStarted: {
        // delay stop of each reel between 350 and 700 ms
        slotMachine.reelStopDelay = utils.generateRandomValueBetween(350, 700)
      }
    }

    // validator to check if player has won
    WinValidator {
      id: winValidator
      height: slotMachine.height // height is the same as slotmachine height
      width: Math.round(height /  240 * 408) // width/height ratio should remain constant
      anchors.centerIn: scene.gameWindowAnchorItem
    }

    // configure top bar
    TopBar {
      id: topBar
      width: scene.gameWindowAnchorItem.width
      anchors.top: scene.gameWindowAnchorItem.top
      anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter
    }

    // configure bottom bar
    BottomBar {
      id: bottomBar
      width: scene.gameWindowAnchorItem.width
      anchors.bottom: scene.gameWindowAnchorItem.bottom
      anchors.horizontalCenter: scene.gameWindowAnchorItem.horizontalCenter

      // link signals to    handler functions
      onStartClicked: scene.startSlotMachine()
      onAutoClicked: scene.autoPlaySlotMachine()
      onIncreaseBetClicked: scene.increaseBetAmount()
      onDecreaseBetClicked: scene.decreaseBetAmount()
      onMaxBetClicked: scene.maxBetAmount()
    }

    // increase bet
    function increaseBetAmount() {
      // prevent bet changes while start button is active (machine is running)
      if(bottomBar.startActive)
        return

      // increase bet amount to next bigger step

      if (betAmount < 5 && creditAmount >= 5)
        betAmount = 5
      else if (betAmount < 4 && creditAmount >= 4)
        betAmount = 4
      else if (betAmount < 3 && creditAmount >= 3)
        betAmount = 3
      else if (betAmount < 2 && creditAmount >= 2)
        betAmount = 2
      else if (betAmount < 1 && creditAmount >= 1)
        betAmount = 1
      else if (betAmount < 8 && creditAmount >= 8)
        betAmount = 8
      else if (betAmount < 10 && creditAmount >= 10)
        betAmount = 10
      else if (betAmount < 15 && creditAmount >= 15)
        betAmount = 15
      else if (betAmount < 20 && creditAmount >= 20)
        betAmount = 20
      else if (betAmount < 25 && creditAmount >= 25)
        betAmount = 25
      else if (betAmount < 30 && creditAmount >= 30)
        betAmount = 30
      else if (betAmount < 35 && creditAmount >= 35)
        betAmount = 35
      else if (betAmount < 40 && creditAmount >= 40)
        betAmount = 40
      else if (betAmount < 45 && creditAmount >= 45)
        betAmount = 45
      else if (betAmount < 50 && creditAmount >= 50)
        betAmount = 50
    }

    // decrease bet
    function decreaseBetAmount() {
      // prevent bet changes while start button is active (machine is running)
      if(bottomBar.startActive)
        return

      // decrease bet amount to next smaller step
      if(betAmount > 45 && creditAmount >= 45)
          betAmount=45
      else if (betAmount > 40 && creditAmount >= 40)
        betAmount = 40
      else if (betAmount > 35 && creditAmount >= 35)
        betAmount = 35
      else if (betAmount > 30 && creditAmount >= 30)
        betAmount = 30
      else if (betAmount > 25 && creditAmount >= 25)
        betAmount = 25
      else if (betAmount > 20 && creditAmount >= 20)
        betAmount = 20
      else if (betAmount > 15 && creditAmount >= 15)
        betAmount = 15
      else if (betAmount > 10 && creditAmount >= 10)
        betAmount = 10
      else if (betAmount > 8 && creditAmount >= 8)
        betAmount = 8
      else if (betAmount > 5 && creditAmount >= 5)
        betAmount = 5
      else if (betAmount > 4 && creditAmount >= 4)
        betAmount = 4
      else if (betAmount > 3 && creditAmount >= 3)
        betAmount = 3
      else if (betAmount > 2 && creditAmount >= 2)
        betAmount = 2
      else if (betAmount > 1&& creditAmount >= 1)
        betAmount = 1
    }

    // set maximum bet
    function maxBetAmount() {
      // prevent bet changes while machine is started
      if(bottomBar.startActive)
        return

      // set bet amount to maximum affordable available step
      if(creditAmount >= 50)
        betAmount = 50
      else if(creditAmount >= 35)
        betAmount = 35
      else if(creditAmount >= 30)
        betAmount = 30
      else if(creditAmount >= 25)
        betAmount = 25
      else if(creditAmount >= 20)
        betAmount = 20
      else if(creditAmount >= 15)
        betAmount = 15
      else if(creditAmount >= 10)
        betAmount = 10
      else if(creditAmount >= 8)
        betAmount = 8
      else if(creditAmount >= 5)
        betAmount = 5
      else if(creditAmount >= 4)
        betAmount = 4
    }

    // auto play slot machine
    function autoPlaySlotMachine() {
      // switch active state of auto button
      bottomBar.autoActive = !bottomBar.autoActive
      if(bottomBar.autoActive)
        startSlotMachine()
    }

    // start slot machine
    function startSlotMachine() {
      if(!slotMachine.spinning && scene.creditAmount >= scene.betAmount) {
        bottomBar.startActive = true

        // reduce player credits
        scene.creditAmount -= scene.betAmount

        // start machine
        winValidator.reset()
        var stopInterval = utils.generateRandomValueBetween(500, 1000) // between 500 and 1000 ms
        slotMachine.spin(stopInterval)
      }
      else if(slotMachine.spinning)
      {
          slotMachine.stop(0)
      }
    }

    // when spin is finished -> validate result
    function spinEnded() {
      bottomBar.startActive = false
      var won = winValidator.validate(slotMachine)
      if(won)
      {
        winValidator.showWinningLines()

      }
      else if(bottomBar.autoActive)
        startSlotMachine()
    }
  }
}
