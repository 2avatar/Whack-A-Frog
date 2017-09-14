//
//  Tile.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class Tile: NSObject {
    
    public enum TileStates {
        case Bad, Good, Empty
    }
    
    private var tileTimer: Timer!
    private var tileState: TileStates!
    private var time: Double
    
    override init(){
       tileState = TileStates.Empty
       time = 0
    }
    
    public func setTileStateWithTimer(state: TileStates, time: Double){
        
        self.tileState = state
        self.time = time
        tileTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(updateTile), userInfo: nil, repeats: false)
    }
    
    public func getTileTimerTime() -> Double{
        return time
    }
    
    public func getTileState() -> TileStates{
        return tileState
    }
    
    public func updateTile(){
        setTileState(state: TileStates.Empty)

    }
    
    public func setTileState(state: TileStates) {
        self.tileState = state
    }
}
