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
    let columns = 10
    
    var cellWidth = 0
    var cellHeight = 0
    
    var population = 0
    var generation = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let column = Int(location.x)/cellWidth
        let row = Int(location.y)/cellHeight
        let creature = gridArray[row][column]
        creature.isAlive = !creature.isAlive
        let populationAdded = creature.isAlive ? 1 : -1
        population += populationAdded
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isUserInteractionEnabled = true
        cellWidth = Int(size.width)/columns
        cellHeight = Int(size.height)/rows
        populateGrid()
    }
    
    func addCreatureAtGrid(row: Int, column: Int) {
        let creature = Creature()
        let position = CGPoint(x: cellWidth*column, y: cellHeight*row)
        creature.position = position
        creature.isAlive = false
        self.addChild(creature)
        gridArray[row].append(creature)
    }
    
    func populateGrid() {
        for row in 0..<rows {
            gridArray.append([])
            for column in 0..<columns {
                addCreatureAtGrid(row: row, column: column)
            }
        }
    }
    
    func countNeighbourghs(){
        
        //loop through every creature in the grid
        for column in 0..<columns {
            for row in 0..<rows {
                let creature = gridArray[row][column]
                
                //reset its neighborCount property to 0
                creature.neighbourCount = 0
                
                //count neighbours
                for cIndex in column-1...column+1 {
                    
                    if cIndex < 0 || cIndex == columns {continue}
                    
                    for rIndex in row-1...row+1 {
                        
                        if rIndex<0||rIndex == rows||(rIndex==row&&cIndex==column) {continue}
                        
                        let neighborCreature = gridArray[rIndex][cIndex]
                        if neighborCreature.isAlive {
                            creature.neighbourCount += 1
                        }
                    }
                }
                print(creature.neighbourCount)
                
            }
            
        }
        
    }
    
    func updateCreatures(){
        
        self.population = 0
        
        for column in 0..<columns {
            for row in 0..<rows {
                let creature = gridArray[row][column]
                
                switch creature.neighbourCount {
                case 3:
                    creature.isAlive = true
                    break
                case 0...1, 4...8:
                    creature.isAlive = false
                    break
                default:
                    //accounts for all other cases
                    break
                }
                
                if creature.isAlive {self.population += 1}
            }
            
        }
    }
    
    func evolve() {
        countNeighbourghs()
        updateCreatures()
        generation+=1
    }
}
