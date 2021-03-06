//
//  Board.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class Board: NSObject {
    
    private var board: [Tile]
    private let numOfTiles: Int
    private let minTileTime = 2
    private let maxTileTime = 5
    private let minNumberOfTiles = 2
    private let maxNumberOfTiles = 5
    
    init (numOfTiles: Int){
        board = [Tile]()
        self.numOfTiles = numOfTiles
        for _ in 0 ..< self.numOfTiles{
            board.append(Tile())
        }
    }
    
    private func setTileStateByPosition(pos: Int, state: Tile.TileStates){
        board[pos].setTileState(state: state)
    }
    
    public func getTileStateByPosition(pos: Int) -> Tile.TileStates{
        return board[pos].getTileState()
    }
    
    public func getTileTimerTimeByPosition(pos: Int) -> Double{
        return board[pos].getTileTimerTime()
    }
    
    private func roleRandomNumberOfTiles() -> Int{
        return randomInt(min: minNumberOfTiles, max: maxNumberOfTiles)
    }
    
    private func roleRandomTimeForTile() -> Int{
        
        let time = randomInt(min: minTileTime, max: maxTileTime+1)
        
        return time
    }
    
    private func roleRandomTargetTile() -> Int{
        
        let target = randomInt(min: 0, max: (numOfTiles-1))
        
        return target
    }
    
    private func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min)))
    }
    
    
    public func setFrogs (tileState: Tile.TileStates){
        
        let numberOfTilesRolled = roleRandomNumberOfTiles()
        
        for _ in 0 ..< numberOfTilesRolled{
            
            let tileTarget = roleRandomTargetTile()
            if (board[tileTarget].getTileState() == Tile.TileStates.Empty){
            let tileTime = roleRandomTimeForTile()
            board[tileTarget].setTileStateWithTimer(state: tileState, time: Double(tileTime))
            }
        }
    }
    
   public func clickTile (pos: Int){
        setTileStateByPosition(pos: pos, state: Tile.TileStates.Empty)
    }
    
    public func clickAllTiles(){
        for i in 0 ..< numOfTiles{
            clickTile(pos: i)
        }
    }
}
