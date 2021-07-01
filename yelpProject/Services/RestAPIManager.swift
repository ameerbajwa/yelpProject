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
    
    func httpRequest() {
        
        let apiUrl = URL(string: "https://api.yelp.com/v3/autocomplete?text=don&latitude=37.786882&longitude=-122.399972")
        var request = URLRequest(url: apiUrl!)
        
        request.httpMethod = "GET"
        request.addValue("Bearer pT5wrgK6nHwAr1lS3VMCyoSvD55nD5X1j-vGeui3FX59Y35-nXa20ADXd-xeya19QL4G4LDkc7Ew18hMmUxpse28kxnBcudq-i17Kin0q_qRC0JvLQBiAD2U6cLcYHYx", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let safeData = data {
                do {
                    let autocomplete = try JSONDecoder().decode(Autocomplete.self, from: safeData)
                    print(autocomplete)
                } catch {
                    print("unexpected error: \(error)")
                }
            }
        }
        
        dataTask.resume()
        
    }
}
