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
    private let maxTileTime = 4
    private let minNumberOfTiles = 0
    private let maxNumberOfTiles = 4
    
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
    
    private func roleRandomNumberOfTiles() -> Int{
        return randomInt(min: minNumberOfTiles, max: maxNumberOfTiles)
    }
    
    private func roleRandomTimeForTile() -> Int{
        return randomInt(min: minTileTime, max: maxTileTime)
    }
    
    private func roleRandomTargetTile() -> Int{
        
        var target = randomInt(min: 0, max: (numOfTiles-1))
        
        while board[target].getTileState() != Tile.TileStates.Empty{
            target = randomInt(min: 0, max: numOfTiles)
        }
        
        return target
    }
    
    private func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min)))
    }
    
    
    public func setFrogs (tileState: Tile.TileStates){
        
        let numberOfTilesRolled = roleRandomNumberOfTiles()
        
        print("number of tiles: \(numberOfTilesRolled)")
        
        for _ in 0 ..< numberOfTilesRolled{
            
            let tileTarget = roleRandomTargetTile()
            let tileTime = roleRandomTimeForTile()
            print("tile target: \(tileTarget), tile time: \(tileTime)")
            board[tileTarget].setTileStateWithTimer(state: tileState, time: Double(tileTime))
            
        }
    }
    
   public func clickTile (pos: Int){
        print("tile \(pos) before clicked, state: \(getTileStateByPosition(pos: pos))")
        setTileStateByPosition(pos: pos, state: Tile.TileStates.Empty)
         print("tile \(pos) after click, state: \(getTileStateByPosition(pos: pos))")
    }
    
    public func clickAllTiles(){
        for i in 0 ..< numOfTiles{
            clickTile(pos: i)
        }
    }
    
}
