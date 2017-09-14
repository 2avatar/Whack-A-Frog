//
//  Game.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit
import AVFoundation

class Game: NSObject {
    
    private var board: Board
    private let points = 1
    private let numOfLifes = 3
    private let gameMaxTime = 60 // seconds
    private var gameTimerCounter: Int
    private var gameTimer: Timer!
    private let gametimerInterval = Double(1)
    private var frogTimer: Timer!
    private let frogTimerInterval = Double(2)
    private var score: Int
    private var life: Int
    private var gameOver: Bool
    private var clickOnFrogSound: AVAudioPlayer?
    
    init (numOfTiles: Int){
        
        self.score = 0
        self.gameTimerCounter = 0
        self.gameOver = false
        self.life = numOfLifes
        board = Board(numOfTiles: numOfTiles)
        
    }
    
    func playSound(soundName: String){
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: ".mp3") else { return }
        do{
            clickOnFrogSound = try AVAudioPlayer(contentsOf: url)
            clickOnFrogSound?.play()
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    public func play(){
        
        gameOver = false;
        
        gameTimer = Timer.scheduledTimer(timeInterval: gametimerInterval, target: self, selector: #selector(updateGameTimer), userInfo: nil, repeats: true)
        
        
        frogTimer = Timer.scheduledTimer(timeInterval: frogTimerInterval, target: self, selector: #selector(setFrogs), userInfo: nil, repeats: true)
        
    }
    
    public func setFrogs(){
        board.setFrogs(tileState: Tile.TileStates.Bad)
        board.setFrogs(tileState: Tile.TileStates.Good)
        
    }
    
    private func checkTime(){
        if gameTimerCounter == gameMaxTime{
            stop()
        }
    }
    
    public func stop(){
        
        gameTimer.invalidate()
        frogTimer.invalidate()
        clickAllTiles()
        gameOver = true

    }
    
    public func restart(){
        gameTimerCounter = 0
        score = 0
        life = numOfLifes
        stop()
        play()
    }
    
    public func updateGameTimer(){
        gameTimerCounter += 1
        checkTime()
    }
    
    private func clickAllTiles(){
        board.clickAllTiles()
    }
    
    public func over() -> Bool{
        return gameOver
    }
    
    public func getScore() -> Int{
        return score
    }
    
    public func getLife() -> Int{
        return life
    }
    
    public func getTime() -> Int{
        return gameTimerCounter
    }
    
    public func getTileStateByPosition(pos: Int) -> Tile.TileStates {
        return board.getTileStateByPosition(pos: pos)
    }
    
    public func getBoardTileTimerTimeByPosition(pos: Int) -> Double{
        return board.getTileTimerTimeByPosition(pos: pos)
    }
    
    public func playerClickedOnTile(pos: Int){
        
        let tileState = board.getTileStateByPosition(pos: pos)
        
        if tileState == Tile.TileStates.Good{
            score += points
           // playSound(soundName: "goodSound")
        }
        if tileState == Tile.TileStates.Bad{
            life -= points
           // playSound(soundName: "badSound")
        }
        
         board.clickTile(pos: pos)
        
        if (life == 0){
        stop()
        }
        
    }
    
}
