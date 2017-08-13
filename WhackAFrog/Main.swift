//
//  Main.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/12/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class Main: UIViewController{
    
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button = self.view.viewWithTag(2) as! UIButton
        button.addTarget(self, action: Selector(("onClick:")), for: .touchUpInside)
        
    }
    
    func onClick(){
        
        let storyboard = UIStoryboard(name: "Main.storyboard", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewController") as UIViewController
        
        present(vc, animated: true, completion: nil)
        
    }
}
