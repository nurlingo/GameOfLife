//
//  Grid.swift
//  GameOfLife
//
//  Created by Nursultan Askarbekuly on 23/06/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import SpriteKit


class Grid: SKSpriteNode {
    
    var gridArray = [[Creature]]()
    
    let rows = 8
    let colums = 10
    
    var cellWidth = 0
    var cellHeight = 0
    
    var population = 0
    var generation = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let column = Int(location.x)/cellWidth
        let row = Int(location.y)/cellHeight
        let creature = gridArray[column][row]
        creature.isAlive = !creature.isAlive
        
        let populationAdded = creature.isAlive ? 1 : -1
        population += populationAdded
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isUserInteractionEnabled = true
        cellWidth = Int(size.width)/colums
        cellHeight = Int(size.height)/rows
        populateGrid()
    }
    
    func addCreatureAtGrid(column: Int, row: Int) {
        
        let creature = Creature()
        let position = CGPoint(x: cellWidth*column, y: cellHeight*row)
        creature.position = position
        creature.isAlive = false
        self.addChild(creature)
        gridArray[column].append(creature)
        
    }
    
    func populateGrid() {
        for column in 0..<colums {
            gridArray.append([])
            for row in 0..<rows {
                addCreatureAtGrid(column: column, row: row)
            }
        }
    }
    
}
