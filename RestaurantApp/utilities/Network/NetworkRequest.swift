//
//  NetworkRequest.swift
//  RestaurantApp
//
//  Created by Samlo Berutu on 30/06/21.
//

import Foundation

class NetworkRequest: NSObject {
    
    
    func requestDataFromAPI(completion : @escaping (Response) -> ()) {
        URLSession.shared.dataTask(with: URL(string: Constant.BASE_URL)!) { data, response, error in
            if let data = data{
                let jsonDecoder = JSONDecoder()
                
                let dataResponse = try! jsonDecoder.decode(Response.self, from: data)
                
                completion(dataResponse)
            }
            
        }.resume()
    }
    
}
