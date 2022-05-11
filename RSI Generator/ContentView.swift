//
//  ContentView.swift
//  RSI Generator
//
//  Created by Tim Randall on 24/4/22.
//

import SwiftUI
import SpriteKit

var touchedDots: Int = 0
var timeLeft: Int = 30

struct GameView: View {
    var scene: SKScene {
        let scene = GameScene2()
        scene.size = CGSize(width: 390, height: 844)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
                    .ignoresSafeArea()
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate { // makes scene conform to the contact delegate
    var displayNum: SKLabelNode!
    var displayTime: SKLabelNode!
    override func didMove(to view: SKView) {
        touchedDots = 0
        timeLeft = 30
        backgroundColor = SKColor.black
        displayNum = SKLabelNode(fontNamed: "Arial")
        displayNum.text = "Hits: \(touchedDots)"
        displayNum.fontSize = 20
        displayNum.position = CGPoint(x: 50, y: 40)
        self.addChild(displayNum)
        displayTime = SKLabelNode(fontNamed: "Arial")
        displayTime.text = "0:\(timeLeft)"
        displayTime.fontSize = 20
        displayNum.position = CGPoint(x: 50, y: 60)
        self.addChild(displayTime)
        run(SKAction.repeatForever(
              SKAction.sequence([
                SKAction.run(addCircle),
                SKAction.wait(forDuration: 0.2)
                ])))
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            timeLeft -= 1
            self.displayTime.text = "0:\(timeLeft)"
            if timeLeft == 0 {
                timer.invalidate()
                let secondScene = GameScene2(size: self.size)
                self.scene?.view?.presentScene(secondScene)
            }
        }
    }
    func addCircle() {
        let circle = SKShapeNode(circleOfRadius: 50)
        circle.fillColor = .yellow
        let randomX = Int.random(in: 1..<391)
        circle.name = "circle"
        circle.position = CGPoint(x: randomX, y: 844)
        addChild(circle)
        
        let actionMove = SKAction.move(to: CGPoint(x: circle.position.x, y: 0), duration: TimeInterval(3.0))
        let actionMoveDone = SKAction.removeFromParent()
        
        circle.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // makes sure that if there are multiple touches, any but the first one will end this function
        guard let touch = touches.first else {
            return
          }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        if touchedNode.name == "circle" {
            touchedNode.removeFromParent()
            touchedDots += 1
            displayNum.text = "Hits: \(touchedDots)"
        }
    }
}
