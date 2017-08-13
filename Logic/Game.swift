//
//  Game.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    var board: Board
    let points = 1
    let gameMaxTime = 60 // seconds
    var gameTimerCounter: Int
    var gameTimer: Timer!
    let gametimerInterval = Double(1)
    var frogTimer: Timer!
    let frogTimerInterval = Double(2)
    var score: Int
    var over: Bool
    
    
    init (numOfTiles: Int){
        
        self.score = 0
        self.gameTimerCounter = 0
        self.over = false
        board = Board(numOfTiles: numOfTiles)
        
    }
    
    func play(){
        
           gameTimer = Timer.scheduledTimer(timeInterval: gametimerInterval, target: self, selector: #selector(updateGameTimer), userInfo: nil, repeats: true)
        
        
           frogTimer = Timer.scheduledTimer(timeInterval: frogTimerInterval, target: self, selector: #selector(setFrogs), userInfo: nil, repeats: true)
        
    }
    
    func setFrogs(){
        
        board.setFrogs(tileState: Tile.TileStates.Bad)
        board.setFrogs(tileState: Tile.TileStates.Good)
        
    }
    
    func checkTime(){
        if gameTimerCounter == gameMaxTime{
            stop()
        }
    }
    
    func stop(){
        
        gameTimer.invalidate()
        frogTimer.invalidate()
        clickAllTiles()
        over = false
    }
    
    func updateGameTimer(){
        gameTimerCounter += 1
        checkTime()
    }
    
    func getGameTimer() -> Int{
        return gameTimerCounter
    }
    
    func clickAllTiles(){
        board.clickAllTiles()
    }
    
    func getTileStateByPosition(pos: Int) -> Tile.TileStates {
        return board.getTileStateByPosition(pos: pos)
    }
    
    func playerClickedOnTile(pos: Int){
        
        let tileState = board.getTileStateByPosition(pos: pos)
        
        if tileState == Tile.TileStates.Good{
            score += points
        }
        if tileState == Tile.TileStates.Bad && score != 0{
            score -= points
        }
        
         board.clickTile(pos: pos)
        
    }
    
}
