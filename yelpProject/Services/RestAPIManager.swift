//
//  RestAPIManager.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 6/30/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

class RestAPIManager {
    
    static let sharedInstance = RestAPIManager()
    
    func httpRequest(apiUrlString: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping (Error) -> Void) {
        
        let baseUrlString = "https://api.yelp.com/v3"
        let urlString = baseUrlString + apiUrlString
        
        let apiUrl = URL(string: urlString)
        var request = URLRequest(url: apiUrl!)
        
        request.httpMethod = "GET"
        request.addValue("Bearer \(APIKey.yelpAPIKey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let safeData = data, error == nil else {
                print("error: \(error!)")
                onFailure(error!)
                return
            }
            onSuccess(safeData)
            
        }
        
        dataTask.resume()
        
    }
}
