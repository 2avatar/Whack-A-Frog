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
    
    var tileState: TileStates {
        get{
            return self.tileState
        }
        set (newState){
            self.tileState = newState
        }
    }
 
        override init(){
        //tileState = TileStates.Empty
    }
}
