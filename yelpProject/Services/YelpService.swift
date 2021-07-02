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
    
    func getBusinessList(searchText: String, onSuccess: @escaping (Businesses) -> Void, onFailure: @escaping (Error) -> Void) {
        
        let lat: CLLocationDegrees = 37.821950
        let lon: CLLocationDegrees = -121.976690
        
//        LocationManager.sharedInstance.getUserLocation { (location) in
//            lat = location.coordinate.latitude
//            lon = location.coordinate.longitude
//        }
        
//        if let lat = lat, let lon = lon {
        let apiUrl = "/businesses/search?term=\(searchText)&latitude=\(lat)&longitude=\(lon)"
        
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
//        }

    }
    
    func getBusiness(businessId: String, onSuccess: @escaping (Business) -> Void, onFailure: @escaping (Error) -> Void) {
        
        let apiUrl = "/business/\(businessId)"
        
        RestAPIManager.sharedInstance.httpRequest(apiUrlString: apiUrl, onSuccess: { data -> Void in
            do {
                let business = try JSONDecoder().decode(Business.self, from: data)
                onSuccess(business)
            } catch {
                print("unexpected error: \(error).")
            }
        }, onFailure: { error -> Void in
            onFailure(error)
        })
        
    }
}
