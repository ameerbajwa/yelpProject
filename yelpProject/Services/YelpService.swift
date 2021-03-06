//
//  YelpService.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 6/30/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation
import CoreLocation

class YelpService {
    
    static let sharedInstance = YelpService()
    
    func getAutocomplete(searchText: String, latitude: CLLocationDegrees?, longitude: CLLocationDegrees?, onSuccess: @escaping (Autocomplete) -> Void, onFailure: @escaping (Error) -> Void) {

        if let lat = latitude, let lon = longitude {
            let apiUrl = "/autocomplete?text=\(searchText)&latitude=\(lat)&longitude=\(lon)"
            
            RestAPIManager.sharedInstance.httpRequest(apiUrlString: apiUrl,
                onSuccess: { data -> Void in
                    do {
                        let autocomplete = try JSONDecoder().decode(Autocomplete.self, from: data)
                        onSuccess(autocomplete)
                    } catch {
                        print("unexpected error: \(error).")
                    }
                }, onFailure:  { error -> Void in
                onFailure(error)
            })
        }
        
    }
    
    func getBusinessList(searchText: String, latitude: CLLocationDegrees?, longitude: CLLocationDegrees?, onSuccess: @escaping (Businesses) -> Void, onFailure: @escaping (Error) -> Void) {
        
        let preparedSearchText = searchText.replacingOccurrences(of: " ", with: "%20")
        
        if let lat = latitude, let lon = longitude {
            let apiUrl = "/businesses/search?term=\(preparedSearchText)&latitude=\(lat)&longitude=\(lon)"
            
            RestAPIManager.sharedInstance.httpRequest(apiUrlString: apiUrl, onSuccess: { data -> Void in
                do {
                    let businesses = try JSONDecoder().decode(Businesses.self, from: data)
                    onSuccess(businesses)
                } catch {
                    print("unexpected error: \(error).")
                }
            }, onFailure: { error -> Void in
                onFailure(error)
            })
        }

    }
    
    func getBusiness(businessId: String, onSuccess: @escaping (BusinessListItem) -> Void, onFailure: @escaping (Error) -> Void) {

        let apiUrl = "/businesses/\(businessId)"

        RestAPIManager.sharedInstance.httpRequest(apiUrlString: apiUrl, onSuccess: { data -> Void in
            do {
                let business = try JSONDecoder().decode(BusinessListItem.self, from: data)
                onSuccess(business)
            } catch {
                print("unexpected error: \(error).")
            }
        }, onFailure: { error -> Void in
            onFailure(error)
        })

    }
}
