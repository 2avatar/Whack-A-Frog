//
//  Board.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class Board: NSObject {
    
    var board: [Tile]
    let numOfTiles: Int
    let minTileTime = 2
    let maxTileTime = 4
    let minNumberOfTiles = 0
    let maxNumberOfTiles = 4
    
    init (numOfTiles: Int){
        board = [Tile]()
        self.numOfTiles = numOfTiles
        for _ in 0 ..< self.numOfTiles{
            board.append(Tile())
        }
    }
    
    func setTileStateByPosition(pos: Int, state: Tile.TileStates){
        board[pos].tileState = state
    }
    
    func getTileStateByPosition(pos: Int) -> Tile.TileStates{
        return board[pos].tileState
    }
    
    func roleRandomNumberOfTiles() -> Int{
        return randomInt(min: minNumberOfTiles, max: maxNumberOfTiles)
    }
    
    func roleRandomTimeForTile() -> Double{
        return Double(randomInt(min: minTileTime, max: maxTileTime))
    }
    
    func roleRandomTargetTile() -> Int{
        
        var target = randomInt(min: 0, max: numOfTiles)
        
        print(board[target].getTileState())
        print(Tile.TileStates.Empty)
        
        while board[target].getTileState() != Tile.TileStates.Empty{
            target = randomInt(min: 0, max: numOfTiles)
        }
        
        return target
    }
    
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1 )))
    }
    
    
    func setFrogs (tileState: Tile.TileStates){
        
        let numberOfTilesRolled = roleRandomNumberOfTiles()
        
        for _ in 0 ..< numberOfTilesRolled{
            
            let tileTarget = roleRandomTargetTile()
            let tileTime = roleRandomTimeForTile()
            
            board[tileTarget].setTileStateWithTimer(state: tileState, time: tileTime)
            
        }
    }
    
    func clickTile (pos: Int){
        setTileStateByPosition(pos: pos, state: Tile.TileStates.Empty)
    }
    
    func clickAllTiles(){
        for i in 0 ..< numOfTiles{
            clickTile(pos: i)
        }
    }
    
}
