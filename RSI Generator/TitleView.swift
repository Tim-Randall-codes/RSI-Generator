//
//  TitleView.swift
//  RSI Generator
//
//  Created by Tim Randall on 8/5/22.
//

import Foundation
import SpriteKit

class GameScene2: SKScene, SKPhysicsContactDelegate {
    var displayTitle: SKLabelNode! // the skscene is the main node and the other nodes are the decendants
    var startButton: SKLabelNode!  // these are created here, then they are initalised by the didMove function
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        backgroundColor = SKColor.yellow
        displayTitle = SKLabelNode(fontNamed: "Arial")
        displayTitle.text = "RSI Generator"
        displayTitle.fontSize = 30
        displayTitle.fontColor = .black
        displayTitle.position = CGPoint(x: size.width * 0.5, y: size.height * 0.66)
        addChild(displayTitle)
        startButton = SKLabelNode(fontNamed: "Arial")
        startButton.text = "Start game"
        startButton.fontSize = 30
        startButton.fontColor = .black
        startButton.name = "start"
        startButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.33)
        addChild(startButton)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
          }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location) // what node is at that point
        if touchedNode.name == "start" {
            let gameScene = GameScene()
            let fade = SKTransition.fade(with: .black, duration: 1)
            self.scene?.view?.presentScene(gameScene, transition: fade)
        }
    }
}
