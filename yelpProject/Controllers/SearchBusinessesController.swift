//
//  SearchBusinessesController.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit
import CoreLocation

class SearchBusinessesController: UIViewController {
    
    var locationManager: CLLocationManager!
    var currentLatitude: CLLocationDegrees?
    var currentLongitude: CLLocationDegrees?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.sharedInstance.getUserLocation { (location) in
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            self.currentLatitude = location.coordinate.latitude
            self.currentLongitude = location.coordinate.longitude
        }

        YelpService.sharedInstance.getAutocomplete(searchText: "sand", latitude: currentLatitude, longitude: currentLongitude, onSuccess: { (autocomplete) in
            print(autocomplete)
        }) { (error) in
            print(error)
        }
        
    }

}


