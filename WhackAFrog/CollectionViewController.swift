//
//  CollectionViewController.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    let scoreLabelString = "Score: "
    let timeLabelString = "Time: "
    let lifeLabelString = "Life: "
    let cellIdentifier = "cell"
    var game: Game!
    var viewTimer: Timer!
    var viewTimerInterval = Double(1)
    var beforeGame = true
    public var imageGood: UIImageView!
    public var imageBad: UIImageView!
    let numOfCols = 4
    let numOfRows = 3
    let TileMargin = CGFloat(5)
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
       // var decoded  = UserDefaults.standard.data(forKey: Main.imageGoodKey)!
       // var decodedImage = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UIImageView
        var data = UserDefaults.standard.object(forKey: Main.imageGoodKey) as! Data
        imageGood = UIImageView(image: UIImage(data: data))
        
        //decoded  = UserDefaults.standard.object(forKey: Main.imageBadKey) as! Data
        //decodedImage = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UIImageView
        data = UserDefaults.standard.object(forKey: Main.imageBadKey) as! Data
        imageBad = UIImageView(image: UIImage(data: data))
        
        initiateTimer()
        game = Game(numOfTiles: numOfCols*numOfRows)
        game.play()
        initiateLabels()
        
    }
    @IBAction func goBack(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Main.storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Main.vcMainName) as UIViewController
        
        self.dismiss(animated: true, completion: nil)
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if (viewTimer.isValid){
            viewTimer.invalidate()
        }
        game.stop()
        
    }
    
    @IBAction func reset(_ sender: Any) {
        beforeGame = true
        initiateTimer()
        game.restart()
        initiateLabels()
        updateView()
          }
    
    func initiateLabels(){
        scoreLabel.text = "\(scoreLabelString) \(game.getScore())"
        timerLabel.text = "\(timeLabelString) \(game.getTime())"
        lifeLabel.text = "\(lifeLabelString) \(game.getLife())"
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
    
    public func setImageGood(image: UIImageView){
        imageGood = image
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let rowsCount = CGFloat(numOfRows)
        let colsCount = CGFloat(numOfCols)
        let width = collectionView.frame.width / rowsCount - (rowsCount * TileMargin)
        let height = collectionView.frame.height / colsCount - (colsCount * TileMargin)
        
        return CGSize(width: width, height: height) // collectionView.frame.height * 0.9
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let position = getIndexPosition(indexPath: indexPath)
        
        game.playerClickedOnTile(pos: position)
          self.collectionView.reloadData()
        scoreLabel.text = "\(scoreLabelString) \(game.getScore())"
        lifeLabel.text = "\(lifeLabelString) \(game.getLife())"
    
        
//            UIView.animate(withDuration: 1, animations: { () -> Void in
//               
//                collectionView.collectionViewLayout.invalidateLayout()
//            }, completion: { (finished) -> Void in
//                
//                
//                collectionView.collectionViewLayout.invalidateLayout()
//            })
        
    }
    
    func getIndexPosition(indexPath: IndexPath) -> Int {
        return indexPath.section + (indexPath.row*numOfCols)
    }
    
    func isTileBad(position: Int) -> Bool {
        if (game.getTileStateByPosition(pos: position) == Tile.TileStates.Bad){
            return true
        }
        return false
    }
    
    func isTileGood(position: Int) -> Bool {
        if (game.getTileStateByPosition(pos: position) == Tile.TileStates.Good){
            return true
        }
        return false
    }
    
    func isTileEmpty(position: Int) -> Bool {
        if (game.getTileStateByPosition(pos: position) == Tile.TileStates.Empty){
            return true
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as UICollectionViewCell
        
        timerLabel.text = "\(timeLabelString) \(game.getTime())"
        
        let position = getIndexPosition(indexPath: indexPath)
        
        if (beforeGame){
            
            if (getIndexPosition(indexPath: indexPath) == (numOfCols*numOfRows)-1){
            beforeGame = false
        }
            
            let initialX = cell.center.x
            let initialY = cell.center.y
            cell.center.x = -10
            cell.center.y = 30
            cell.alpha = 0.7
            UIView.animate(withDuration: 1, animations: { () -> Void in
                cell.center.x = initialX
                cell.center.y = initialY
                collectionView.collectionViewLayout.invalidateLayout()
            }, completion: { (finished) -> Void in
                cell.backgroundColor = nil
                cell.alpha = 1
                collectionView.collectionViewLayout.invalidateLayout()
            })
        }
        
        
        if (isTileEmpty(position: position) && cell.backgroundView != nil){
            
            cell.backgroundView = nil
        }
        
      // let tileTimerTime = game.getBoardTileTimerTimeByPosition(pos: position)
        if (isTileBad(position: position) && cell.backgroundView == nil){
            
            cell.backgroundView = imageBad
            cell.backgroundView!.alpha = 0
            UIView.animate(withDuration: 1, animations: { () -> Void in
                cell.backgroundView!.alpha = 1
                collectionView.collectionViewLayout.invalidateLayout()
            }, completion: { (finished) -> Void in
        
                collectionView.collectionViewLayout.invalidateLayout()
            })
           
        }
        
        if (isTileGood(position: position) && cell.backgroundView == nil){
            
            cell.backgroundView = imageGood
            cell.backgroundView!.alpha = 0
            UIView.animate(withDuration: 1, animations: { () -> Void in
                cell.backgroundView!.alpha = 1
                collectionView.collectionViewLayout.invalidateLayout()
            }, completion: { (finished) -> Void in
                
                collectionView.collectionViewLayout.invalidateLayout()
            })

        }

        if (game.over()){
            viewTimer.invalidate()

            cell.backgroundColor = UIColor.blue
            cell.alpha = 0.7
            let initialX = cell.center.x
            let initialY = cell.center.y
            UIView.animate(withDuration: 1, animations: { () -> Void in
                cell.center.x = -10
                cell.center.y = 30
                collectionView.collectionViewLayout.invalidateLayout()
            }, completion: { (finished) -> Void in
                cell.alpha = 0
                cell.center.x = initialX
                cell.center.y = initialY
                collectionView.collectionViewLayout.invalidateLayout()
            })

        }
        
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(TileMargin, TileMargin, TileMargin, TileMargin)
    }
}

