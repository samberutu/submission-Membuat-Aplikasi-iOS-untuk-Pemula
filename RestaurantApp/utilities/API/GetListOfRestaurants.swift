//
//  GetRestaurantList.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 28/06/21.
//

import Foundation

class GetListOfResaurants : NSObject {
    
    // subscribe dari network request
    private var service : NetworkRequest?
    //set data api ke model
    //memberitahu jika ada darta dari api berubah maka closure akan menotice
    private(set) var dataFromAPI : Response? {
        didSet{
            self.bindRestaurantViewController()
        }
    }
    
    override init(){
        super.init()
        service = NetworkRequest()
        fetchData()
    }
    
    //closure untuk mengingat data "bind API"
    var bindRestaurantViewController : (() -> ()) = {}
    
    
    func fetchData(){
        service?.requestDataFromAPI { object in
            self.dataFromAPI = object
        }
   }
    
}

