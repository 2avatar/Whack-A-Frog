//
//  Main.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 8/12/17.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit

class Main: UIViewController{
    
    enum Difficulty{ case Hard, Medium, Easy }
    
    
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        button.addTarget(self, action: #selector(Main.onClick), for: .touchUpInside)
        
    }
    
    func onClick(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "game") as UIViewController
        
        present(vc, animated: true, completion: nil)
        
    }
}
