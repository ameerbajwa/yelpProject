//
//  BusinessMapController.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit
import MapKit

class BusinessMapController: UIViewController, MKMapViewDelegate {
    
    var spinnerView = SpinnerView()
    var selectedBusinessId: String?
    var userLocation: CLLocationCoordinate2D?
    var mapView = MKMapView()
    
    var businessViewModel: BusinessListItemViewModel? {
        didSet {
            DispatchQueue.main.async {
                
                self.businessView.businessListItemViewModel = self.businessViewModel
                if let usrLoc = self.userLocation, let bsnLoc = self.businessViewModel?.location {
                    let distanceValue = (CLLocation(latitude: usrLoc.latitude, longitude: usrLoc.longitude).distance(from: CLLocation(latitude: bsnLoc.latitude, longitude: bsnLoc.longitude))/1609.0)
                    let distanceString = String(format: "%.2f", distanceValue)
                    self.distanceLabel.text = "\(distanceString) miles away from you"
                }
                self.render(userLocation: self.userLocation, location: self.businessViewModel?.location)
                self.businessView.reloadInputViews()
                
            }
        }
    }
    
    var businessView = BusinessView()
    var dividerView = UIView()
    var distanceView = UIView()
    var distanceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpScreen()
        
        DispatchQueue.main.async {
            self.spinnerView.createSpinnerView(view: self.view)
        }
        
        if let id = selectedBusinessId {
            YelpService.sharedInstance.getBusiness(businessId: id) { business in
                self.businessViewModel = BusinessListItemViewModel(business: business)
                DispatchQueue.main.async {
                    self.spinnerView.dismissSpinnerView()
                }
            } onFailure: { error in
                print(error)
            }
        }
    
    }
    
    func render(userLocation: CLLocationCoordinate2D?, location: CLLocationCoordinate2D?) {
        
        if let usrLoc = userLocation, let bsnLoc = location, let safeTitle = businessViewModel?.name {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
            
            let centerLatitude = (usrLoc.latitude + bsnLoc.latitude) / 2
            let centerLongitude = (usrLoc.longitude + bsnLoc.longitude) / 2
            let centerLoc = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
            
            let region = MKCoordinateRegion(center: centerLoc, span: span)
            
            self.mapView.setRegion(region, animated: true)
            
            let pin = MKPointAnnotation()
            pin.coordinate = bsnLoc
            pin.title = safeTitle
            mapView.addAnnotation(pin)
            self.mapView.showsUserLocation = true
                        
        }

    }
    
    func setUpScreen() {
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        distanceLabel.numberOfLines = 0
        self.distanceView.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(distanceView)
        distanceView.translatesAutoresizingMaskIntoConstraints = false
        
        dividerView.backgroundColor = .darkGray
        self.view.addSubview(dividerView)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        businessView.setUpConstraints()
        self.view.addSubview(businessView)
        businessView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            distanceLabel.centerYAnchor.constraint(equalTo: self.distanceView.centerYAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: self.distanceView.leadingAnchor, constant: 10.0),
            distanceLabel.trailingAnchor.constraint(equalTo: self.distanceView.trailingAnchor, constant: -10.0),
            
            distanceView.topAnchor.constraint(equalTo: self.mapView.safeAreaLayoutGuide.bottomAnchor),
            distanceView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            distanceView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            distanceView.heightAnchor.constraint(equalToConstant: 50.0),
            
            dividerView.topAnchor.constraint(equalTo: self.distanceView.bottomAnchor, constant: 5.0),
            dividerView.heightAnchor.constraint(equalToConstant: 1.0),
            dividerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            dividerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            
            businessView.topAnchor.constraint(equalTo: self.dividerView.safeAreaLayoutGuide.bottomAnchor),
            businessView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            businessView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            businessView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
//            businessView.heightAnchor.constraint(equalToConstant: 150.0)
            
        ])
    }

}
