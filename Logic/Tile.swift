//
//  Tile.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class Tile: NSObject {
    
    enum TileStates {
        case Bad, Good, Empty
    }
    
    var tileTimer: Timer!
    var tileState: TileStates!
    
    override init(){
       tileState = TileStates.Empty
    }
    
    func setTileStateWithTimer(state: TileStates, time: Double){
        
        self.tileState = state
        tileTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(update), userInfo: nil, repeats: false)
    }
    
    func getTileState() -> TileStates{
        return tileState
    }
    
    func update() {
            self.tileState = TileStates.Empty
    }
}
