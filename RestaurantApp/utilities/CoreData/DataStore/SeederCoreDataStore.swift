//
//  SeederCoreDataStore.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 12/07/21.
//

import UIKit
import CoreData

class SeederCoreDataStore {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var restorantCore : [RestaurantCore]?
    
    func getRestorantCore() -> [RestaurantCore]? {
        do{
            let request = RestaurantCore.fetchRequest() as NSFetchRequest<RestaurantCore>
            request.returnsObjectsAsFaults = false
            
            restorantCore = try context.fetch(request)
        }catch{
            print("Error Occured! \(error)")
        }
        
        return restorantCore
    }
    
    func checkId (_ id :String) -> Bool{
        let data = getRestorantCore()
        for (_,value) in data!.enumerated() {
            
            if id == value.id! {
                return true
            }
            
        }
        
        return false
        
    }
    
    func add(restaurant : Restaurant){
        let newData = RestaurantCore(context: self.context)
        
        newData.id = restaurant.id
        newData.name = restaurant.name
        newData.pictureId = restaurant.pictureID
        newData.desc = restaurant.restaurantDescription
        newData.rating = restaurant.rating
        newData.city = restaurant.city
        save()
    }
    
    func delete(_ id: String){
        let data = getRestorantCore()
        for (idx,value) in data!.enumerated() {
            
            if id == value.id! {
                self.context.delete(data![idx])
                break
            }
            
        }
        save()
        
    }
    
    func save() {
        do {
            try self.context.save()
        } catch {
            print("Error Occured! \(error)")
        }
    }
    
    
}
