//
//  CollectionViewController.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/10/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class GameScene: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate{
    
    let scoreLabelString = "Score:"
    let timeLabelString = "Time:"
    let lifeLabelString = "Life:"
    let collectionViewCellName = "CVCell"
    let numOfCols = 4
    let numOfRows = 3
    let maxScores = 10
    let TileMargin = CGFloat(5)
    let locationManager = CLLocationManager()
    var game: Game!
    var viewTimer: Timer!
    var viewTimerInterval = Double(1)
    var beforeGame = true
    var latitude:Double = 0
    var longtitude:Double = 0
    public var imageGood: UIImageView!
    public var imageBad: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        var data = UserDefaults.standard.object(forKey: Main.imageGoodKey) as! Data
        imageGood = UIImageView(image: UIImage(data: data))
        
        data = UserDefaults.standard.object(forKey: Main.imageBadKey) as! Data
        imageBad = UIImageView(image: UIImage(data: data))
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        initiateTimer()
        game = Game(numOfTiles: numOfCols*numOfRows)
        game.play()
        initiateLabels()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        latitude = location.coordinate.latitude
        longtitude = location.coordinate.longitude
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        
        if (game.over()){
         storeData()
        }
        
        let storyboard = UIStoryboard(name: Main.storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Main.vcMainName) as UIViewController
        
        locationManager.stopUpdatingLocation()
        
        self.dismiss(animated: true, completion: nil)
        present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
         locationManager.stopUpdatingLocation()
        
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
        locationManager.startUpdatingLocation()
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellName, for: indexPath) as UICollectionViewCell
        
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
        //    cell.backgroundView!.alpha = 0
        //    UIView.animate(withDuration: 1, animations: { () -> Void in
        //        cell.backgroundView!.alpha = 1
         //       collectionView.collectionViewLayout.invalidateLayout()
        //    }, completion: { (finished) -> Void in
        //
        //        collectionView.collectionViewLayout.invalidateLayout()
        //    })
           
        }
        
        if (isTileGood(position: position) && cell.backgroundView == nil){
            
            cell.backgroundView = imageGood
         //   cell.backgroundView!.alpha = 0
         //   UIView.animate(withDuration: 1, animations: { () -> Void in
          //      cell.backgroundView!.alpha = 1
          //      collectionView.collectionViewLayout.invalidateLayout()
         //   }, completion: { (finished) -> Void in
                
          //      collectionView.collectionViewLayout.invalidateLayout()
          //  })

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
    
    func storeData(){
        
        locationManager.stopUpdatingLocation()
        let fetchRequest:NSFetchRequest<Scores> = Scores.fetchRequest()
        let username:String = UserDefaults.standard.string(forKey: Main.usernameKey)!
        
        do{
            
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            var minScore = Int32(1000)
            var found:Bool = false

            if (game.getScore() != 0){
                
    
                
            if (searchResults.count >= maxScores){
                
                NSLog("\(searchResults.count)")
                
                for result in searchResults as [Scores]{
                    if (minScore > result.score && result.score != 0){
                        minScore = result.score
                    }
                }
                NSLog("\(minScore)")
                NSLog("\(game.getScore())")
                if (minScore < Int32(game.getScore())){
                    for result in searchResults as [Scores]{
                        if ((minScore == result.score) && !found){
                            
                            NSLog("Inside")
                            found = true
                            DatabaseController.getContext().delete(result)
                            
                            DatabaseController.saveContext()

                            let scores:Scores = NSEntityDescription.insertNewObject(forEntityName: Main.scoresClassName, into: DatabaseController.getContext()) as! Scores

                            
                            scores.latitude = self.latitude
                            scores.longtitude = self.longtitude
                            scores.name = username
                            scores.score = Int32(game.getScore())
                            
                            DatabaseController.saveContext()
                            
                        }
                    }
                }
            }
            else{
                
                let scores:Scores = NSEntityDescription.insertNewObject(forEntityName: Main.scoresClassName, into: DatabaseController.getContext()) as! Scores

                
                NSLog("Inside 2")
                scores.latitude = self.latitude
                scores.longtitude = self.longtitude
                scores.name = username
                scores.score = Int32(game.getScore())
                
                DatabaseController.saveContext()

            }
        }
  
   
            
            
            
        }
        catch{
            print("Database Error: \(error)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(TileMargin, TileMargin, TileMargin, TileMargin)
    }
}

