//
//  LocationManager.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
//    func setupLocationManager() {
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.startUpdatingLocation()
//        manager.requestWhenInUseAuthorization()
//    }
//    
//    func checkLocationServices() {
//        if CLLocationManager.locationServicesEnabled() {
//            setupLocationManager()
//            checkLocationAuthorization()
//        } else {
//            // show alert letting the userknow they have to turn this on.
//            print("locatino services off")
//        }
//    }
//    
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus() {
//        case .authorizedWhenInUse:
//            break
//        case .denied:
//            // show alert instructing them how to turn on permissions
//            break
//        case .notDetermined:
//            manager.requestWhenInUseAuthorization()
//        case .restricted:
//            // show an alert letting them know what's up
//            break
//        case .authorizedAlways:
//            break
//        @unknown default:
//            fatalError("")
//        }
//    }
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
        let coordinate = manager.location?.coordinate
        print("latitude: \(coordinate?.latitude)")
        print("longitude: \(coordinate?.longitude)")
    }
}
