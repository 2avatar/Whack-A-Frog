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
        button.addTarget(self, action: #selector(Main.onClick), for: .touchUpInside)
        
    }
    
    func onClick(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "game") as UIViewController
        
        present(vc, animated: true, completion: nil)
        
    }
}
