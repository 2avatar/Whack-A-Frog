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
    
    
    static let imageGoodKey = "imageGoodKey"
    static let imageBadKey = "imageBadKey"
    static let storyboardName = "Main"
    static let vcChooseAnImageName = "chooseAnImage"
    static let vcGameName = "game"
    static let vcMainName = "main"
    static let imageGoodURL = "Images/good.png"
    static let imageBadURL = "Images/bad.png"
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var chooseAnImage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        button.addTarget(self, action: #selector(Main.onClick), for: .touchUpInside)
        chooseAnImage.addTarget(self, action: #selector(Main.chooseAnImageOnClick), for: .touchUpInside)
        
        if (UserDefaults.standard.object(forKey: Main.imageGoodKey) as? Data) == nil{
            UserDefaults.standard.set(UIImagePNGRepresentation(UIImage(named: Main.imageGoodURL)!), forKey: Main.imageGoodKey)
        }

        if (UserDefaults.standard.object(forKey: Main.imageBadKey) as? Data) == nil{
            UserDefaults.standard.set(UIImagePNGRepresentation(UIImage(named: Main.imageBadURL)!), forKey: Main.imageBadKey)

        }
            UserDefaults.standard.synchronize()
    }
    
    
    
    func chooseAnImageOnClick(){
        
        let storyboard = UIStoryboard(name: Main.storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Main.vcChooseAnImageName) as UIViewController
        
        self.dismiss(animated: true, completion: nil)
        present(vc, animated: true, completion: nil)
        
    }
    
    func onClick(){
        
        let storyboard = UIStoryboard(name: Main.storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Main.vcGameName) as UIViewController
        
        self.dismiss(animated: true, completion: nil)
        present(vc, animated: true, completion: nil)
        
    }
}
