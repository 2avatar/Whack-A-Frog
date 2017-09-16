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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return result.count+1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        let nameLabel = cell.viewWithTag(1) as! UILabel
        let scoreLabel = cell.viewWithTag(2) as! UILabel
        
        if (indexPath.row > 1){
            
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
