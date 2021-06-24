//
//  Favorites+CoreDataProperties.swift
//  FetchRewards
//
//  Created by Prithiv Dev on 23/06/21.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var id: Double

}
