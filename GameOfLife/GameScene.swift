//
//  GameScene.swift
//  GameOfLife
//
//  Created by Nursultan Askarbekuly on 23/06/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gridNode: Grid!
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    var stepButton: MSButtonNode!
    var populationLabel: SKLabelNode!
    var generationLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        gridNode = self.childNode(withName: "gridNode") as! Grid
        playButton = self.childNode(withName: "playButton") as! MSButtonNode
        pauseButton = self.childNode(withName: "pauseButton") as! MSButtonNode
        stepButton = self.childNode(withName: "stepButton") as! MSButtonNode
        populationLabel = self.childNode(withName: "populationLabel") as! SKLabelNode
        generationLabel = self.childNode(withName: "generationLabel") as! SKLabelNode
        stepButton.selectedHandler = { self.stepSimulation() }
        pauseButton.selectedHandler = { [unowned self] in
            self.isPaused = true
        }
        playButton.selectedHandler = { [unowned self] in
            self.isPaused = false
        }

        
        let delay = SKAction.wait(forDuration: 0.5)
        let callMethod = SKAction.perform(#selector(stepSimulation), onTarget: self)
        let stepSequence = SKAction.sequence([delay,callMethod])
        let simulation = SKAction.repeatForever(stepSequence)
        self.run(simulation)
        self.isPaused = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
    
    func stepSimulation() {
        gridNode.evolve()
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
    
}
