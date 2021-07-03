//
//  BusinessListController.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit
import CoreLocation

class BusinessListController: UITableViewController {

    var spinnerView = SpinnerView()
    var searchTerm: String?
    
    var businessListViewModel = BusinessListViewModel()
    var selectedBusinessId: String?
    var userLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.spinnerView.createSpinnerView(view: self.view)
        }
        
        self.tableView.register(BusinessListCell.self, forCellReuseIdentifier: "businessListCell")
        
        if let safeSearchTerm = searchTerm, let currentLatitude = userLocation?.latitude, let currentLongitude = userLocation?.longitude {
            YelpService.sharedInstance.getBusinessList(searchText: safeSearchTerm, latitude: currentLatitude, longitude: currentLongitude, onSuccess: { (businesses) in
                self.businessListViewModel.businessList = businesses.businesses.map(BusinessListItemViewModel.init)
                                
                DispatchQueue.main.async {
                    self.spinnerView.dismissSpinnerView()
                    self.tableView.reloadData()
                }
            }) { (error) in
                print(error)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select business from list to view in map"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return businessListViewModel.businessList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessListCell", for: indexPath) as? BusinessListCell
        cell?.businessListItemViewModel = businessListViewModel.businessList[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.selectedBusinessId = businessListViewModel.businessList[indexPath.row].id
//        self.businessViewModel = businessListViewModel.businessList[indexPath.row]
        self.performSegue(withIdentifier: "businessListToMapSegue", sender: nil)
    }

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "businessListToMapSegue" {
            let vc = segue.destination as! BusinessMapController
            vc.userLocation = userLocation
            vc.selectedBusinessId = selectedBusinessId
        }
    }

}
