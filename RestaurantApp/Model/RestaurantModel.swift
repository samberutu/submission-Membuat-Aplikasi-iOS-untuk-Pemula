//
//  RestaurantModel.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 29/06/21.
//

import Foundation
struct RestaurantModel : Codable{
    let id : String
    let name : String
    let description : String
    let pictureId : String
    let city : String
    let rating : Double
}

struct Response : Codable{
    let error : Bool
    let message : String
    let count : Int
    let restaurants : [RestaurantModel]
}

//model detail restoran
struct DetailResponse : Codable {
    let error : Bool
    let message : String
    let restaurant : Restaurant
}
struct Restaurant : Codable  {
    let id, name, restaurantDescription, city, address, pictureID : String
    let categories : [Name]
    let menus : Menus
    let rating :Double
    let customerReviews : [CustomerReviews]
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case restaurantDescription = "description"
        case city, address
        case pictureID = "pictureId"
        case categories, menus, rating, customerReviews
    }
}
struct CustomerReviews : Codable{
    let name,review,date : String
}
struct Menus : Codable {
    let foods,drinks : [Name]
}
struct Name : Codable {
    let name : String
}


