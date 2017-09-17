//
//  TableView.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 15/09/2017.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit
import CoreData

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let tableViewCellName = "TVCell"
    @IBOutlet weak var tableView: UITableView!
    
    var result:[Scores]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchScores()
        
    }
    
    func fetchScores(){
        
        do{
            
            let fetchRequest:NSFetchRequest<Scores> = Scores.fetchRequest()

            result = try DatabaseController.getContext().fetch(fetchRequest)

                    }
        catch{
            print("Database Error: \(error)")
        }

    }
    
    @IBAction func onClickGoBack(_ sender: Any) {
    
        let storyboard = UIStoryboard(name: Main.storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Main.vcMainName) as UIViewController
        
        self.dismiss(animated: true, completion: nil)
        present(vc, animated: true, completion: nil)

    }
    
    
    
    func deleteAllData(){
        
        for results in result as [Scores]{
            DatabaseController.getContext().delete(results)
        }
        DatabaseController.saveContext()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return result.count+1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
       // let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellName, for: indexPath)
        
        let nameLabel = cell.contentView.viewWithTag(1) as! UILabel
        let scoreLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        if (indexPath.row > 0){
            
            nameLabel.text = result[indexPath.row-1].name
            scoreLabel.text = String(result[indexPath.row-1].score)
            
        }
        else{
            
            nameLabel.text = "Name"
            scoreLabel.text = "Score"
            
        }
        
        return cell
    }
    
    
}
