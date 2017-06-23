//
//  Creature.swift
//  GameOfLife
//
//  Created by Nursultan Askarbekuly on 23/06/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import SpriteKit

class Creature: SKSpriteNode {
    
    var isAlive: Bool = false {
        didSet{
            isHidden = !isAlive
        }
    }
    
    var neighbourCount = 0
    
    init(){
        let texture = SKTexture(imageNamed: "bubble")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        zPosition = 1
        anchorPoint = CGPoint(x: 0, y: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
