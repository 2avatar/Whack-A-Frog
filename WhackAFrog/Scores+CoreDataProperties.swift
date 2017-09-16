//
//  Scores+CoreDataProperties.swift
//  
//
//  Created by Eviatar Admon on 16/09/2017.
//
//

import Foundation
import CoreData


extension Scores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Scores> {
        return NSFetchRequest<Scores>(entityName: "Scores")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longtitude: Double
    @NSManaged public var name: String?
    @NSManaged public var score: Int32

}
