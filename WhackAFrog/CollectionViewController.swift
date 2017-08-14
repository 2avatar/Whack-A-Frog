//
//  CollectionViewController.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var game: Game!
    var viewTimer: Timer!
    var viewTimerInterval = Double(1)
    let numOfTiles = 10
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewTimer = Timer.scheduledTimer(timeInterval: viewTimerInterval, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
        game = Game(numOfTiles: numOfTiles)
        game.play()
    }
    
    func updateView(){
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfTiles
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        game.playerClickedOnTile(pos: indexPath.row)
          self.collectionView?.reloadData()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        
        print("index: \(indexPath.row) , state: \(game.getTileStateByPosition(pos: indexPath.row))")
        
        
        if (game.getTileStateByPosition(pos: indexPath.row) == Tile.TileStates.Bad){
            
            cell.backgroundView = setCellImage(image: "bad.jpg")

        }
        
        if (game.getTileStateByPosition(pos: indexPath.row) == Tile.TileStates.Good){
            cell.backgroundView = setCellImage(image: "good.jpg")
        }
        
        if (game.getTileStateByPosition(pos: indexPath.row) == Tile.TileStates.Empty){
            cell.backgroundView = nil
        }
        
        if (game.over()){
            
            viewTimer.invalidate()
            
        }
        
        return cell
    }
    
    func setCellImage(image: String) -> UIImageView{
        return UIImageView(image: UIImage(named: image))
    }
}

