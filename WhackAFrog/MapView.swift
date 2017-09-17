//
//  MapView.swift
//  WhackAFrog
//
//  Created by Eviatar Admon on 15/09/2017.
//  Copyright © 2017 Eviatar Admon. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapView: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
     var result:[Scores]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.showsUserLocation = true
        
        fetchScores()

        addAnnotations()
        
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
    
    func addAnnotations(){
        
    
    for results in result as [Scores]{
        
        let annotation = MKPointAnnotation()
    
        let name = results.name!
        let score = String(results.score)
        
        annotation.title = "Name: \(name), Score: \(score)"
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: results.latitude, longitude: results.longtitude)
        mapView.addAnnotation(annotation)
        
    }
    }
    
    @IBAction func onClickGoBack(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Main.storyboardName, bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: Main.vcMainName) as UIViewController
        
        self.dismiss(animated: true, completion: nil)
        present(vc, animated: true, completion: nil)

    }

    
    
}
