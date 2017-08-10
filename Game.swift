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
    var score: Int{
        get{
            return self.score
        }
        set (points){
            self.score += points
        }
    }
    
    init (numOfTiles: Int){
        //score = 0
        board = Board(numOfTiles: numOfTiles)
    }
    
    
}
