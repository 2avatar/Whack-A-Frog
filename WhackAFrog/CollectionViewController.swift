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
    let numOfCols = 4
    let numOfRows = 3
    let TileMargin = CGFloat(5)
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        initiateTimer()
        game = Game(numOfTiles: numOfCols*numOfRows)
        game.play()
        initiateLabels()
        
    }
    @IBAction func goBack(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "main") as UIViewController
        
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidLoad()
        
        if (viewTimer.isValid){
            viewTimer.invalidate()
        }
        game.stop()
        
    }
    
    
    @IBAction func reset(_ sender: Any) {
        initiateTimer()
        game.restart()
        initiateLabels()
    }
    
    func initiateLabels(){
        scoreLabel.text = "Score: \(game.getScore())"
        timerLabel.text = "Time: \(game.getTime())"
    }
    
    func initiateTimer(){
        
        if (viewTimer != nil){
            if (viewTimer.isValid){
                viewTimer.invalidate()
            }
        }
        viewTimer = Timer.scheduledTimer(timeInterval: viewTimerInterval, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
    }
    
    func updateView(){
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfRows
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numOfCols
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let rowsCount = CGFloat(numOfRows)
        let colsCount = CGFloat(numOfCols)
        let width = collectionView.frame.width / rowsCount - (rowsCount * TileMargin)
        let height = collectionView.frame.height / colsCount - (colsCount * TileMargin)
        
        
        return CGSize(width: width, height: height) // collectionView.frame.height * 0.9
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let position = indexPath.section + (indexPath.row*numOfCols)

        
        game.playerClickedOnTile(pos: position)
          self.collectionView.reloadData()
        scoreLabel.text = "Score: \(game.getScore())"
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        
        
        
        timerLabel.text = "Time: \(game.getTime())"
        
         let position = indexPath.section + (indexPath.row*numOfCols)
        
        if (game.getTileStateByPosition(pos: position) == Tile.TileStates.Bad){
            cell.backgroundView = setCellImage(image: "Images/bad.jpg")
        }
        
        if (game.getTileStateByPosition(pos: position) == Tile.TileStates.Good){
            cell.backgroundView = setCellImage(image: "Images/good.jpg")
        }
        
        if (game.getTileStateByPosition(pos: position) == Tile.TileStates.Empty){
            cell.backgroundView = nil
        }
        
        if (game.over()){
            
            viewTimer.invalidate()
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(TileMargin, TileMargin, TileMargin, TileMargin)
    }

    
    func setCellImage(image: String) -> UIImageView{
        return UIImageView(image: UIImage(named: image))
    }
}

