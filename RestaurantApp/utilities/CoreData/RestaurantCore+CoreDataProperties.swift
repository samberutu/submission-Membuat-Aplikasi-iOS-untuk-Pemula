//
//  RestaurantCore+CoreDataProperties.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 13/07/21.
//
//

import Foundation
import CoreData


extension RestaurantCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantCore> {
        return NSFetchRequest<RestaurantCore>(entityName: "RestaurantCore")
    }

    @NSManaged public var city: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var pictureId: String?
    @NSManaged public var rating: Double

}

extension RestaurantCore : Identifiable {

}
