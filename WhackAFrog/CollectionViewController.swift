//
//  CollectionViewController.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController{
    
    var game: Game!
    let numOfTiles = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game = Game(numOfTiles: numOfTiles)
        game.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfTiles
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        game.playerClickedOnTile(pos: indexPath.row)
   
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        
        let button = cell.viewWithTag(1) as! UIButton
        
        if (game.getTileStateByPosition(pos: indexPath.row) == Tile.TileStates.Bad){
        button.setBackgroundImage(UIImage(named: "Images/bad.jpg"), for: UIControlState.normal)
        }
        
        if (game.getTileStateByPosition(pos: indexPath.row) == Tile.TileStates.Good){
          button.setBackgroundImage(UIImage(named: "Images/good.jpg"), for: UIControlState.normal)
        }
        
        if (game.getTileStateByPosition(pos: indexPath.row) == Tile.TileStates.Empty){
            button.setBackgroundImage(nil, for: UIControlState.normal)
        }
        
        if (game.over){
            
            let storyboard = UIStoryboard(name: "Main.storyboard", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "over") as UIViewController
        
            present(vc, animated: true, completion: nil)
        }

        return cell
    }
}

