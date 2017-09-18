//
//  Instruction.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 14/09/2017.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit
import Photos

class ChooseAnImage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var imageViewGood: UIImageView!
    @IBOutlet weak var imageViewBad: UIImageView!
    @IBOutlet weak var goBackButton: UIButton!
    var userChoseGood: Bool!
    var imageGoodURL: URL!
    var imageBadURL: URL!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        goBackButton.addTarget(self, action: #selector(ChooseAnImage.onClickGoBack), for: .touchUpInside)
        
        imagePicker.delegate = self
        userChoseGood = true
        
        var data = UserDefaults.standard.object(forKey: Main.imageGoodKey) as! Data
        imageViewGood.image = UIImage(data: data)
        data = UserDefaults.standard.object(forKey: Main.imageBadKey) as! Data
        imageViewBad.image = UIImage(data: data)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
  
    @IBAction func badRestoreDefault(_ sender: Any) {
        
        imageViewBad.image = UIImage(named: Main.imageBadURL)!
        
        UserDefaults.standard.set(UIImagePNGRepresentation(UIImage(named: Main.imageBadURL)!), forKey: Main.imageBadKey)
        
    }
    
    @IBAction func goodRestoreDefault(_ sender: Any) {
        
        imageViewGood.image = UIImage(named: Main.imageGoodURL)!
        
        UserDefaults.standard.set(UIImagePNGRepresentation(UIImage(named: Main.imageGoodURL)!), forKey: Main.imageGoodKey)
    }
    
    @IBAction func imageButtonGood(_ sender: Any) {
    
        userChoseGood = true
        askPermissionToPhotoLibrary()
        showImagePicker()
     
    }
    
    @IBAction func imageButtonBad(_ sender: Any) {

        userChoseGood = false
        askPermissionToPhotoLibrary()
        showImagePicker()
    
    }
    
    func askPermissionToPhotoLibrary(){
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                  
                } else {
                    
                }
            })
        
        }
    }
    
    func showImagePicker(){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            var imageGoodOrBad: String!
            
            if (userChoseGood){
            imageViewGood.contentMode = .scaleAspectFit
            imageViewGood.image = pickedImage
            imageGoodOrBad = Main.imageGoodKey
            }
            else{
            imageViewBad.contentMode = .scaleAspectFit
            imageViewBad.image = pickedImage
            imageGoodOrBad = Main.imageBadKey
            }
            
           // let encodedData = NSKeyedArchiver.archivedData(withRootObject: pickedImage)
            UserDefaults.standard.set(UIImagePNGRepresentation(pickedImage), forKey: imageGoodOrBad)
            UserDefaults.standard.synchronize()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func onClickGoBack(){
        
        let storyboard = UIStoryboard(name: Main.storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Main.vcMainName) as UIViewController
        self.dismiss(animated: true, completion: nil)
        present(vc, animated: true, completion: nil)

    }
    
}
