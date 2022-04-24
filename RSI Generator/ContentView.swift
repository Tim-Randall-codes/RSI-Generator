//
//  ContentView.swift
//  RSI Generator
//
//  Created by Tim Randall on 24/4/22.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 390, height: 844)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
                    .ignoresSafeArea()
    }
}

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        run(SKAction.repeatForever(
              SKAction.sequence([
                SKAction.run(addCircle),
                SKAction.wait(forDuration: 0.2)
                ])))
    }
    func addCircle() {
        let circle = SKShapeNode(circleOfRadius: 50)
        circle.fillColor = .yellow
        let randomX = Int.random(in: 1..<391)
        circle.position = CGPoint(x: randomX, y: 844)
        addChild(circle)
        
        let actionMove = SKAction.move(to: CGPoint(x: circle.position.x, y: 0), duration: TimeInterval(3.0))
        let actionMoveDone = SKAction.removeFromParent()
        
        circle.run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
