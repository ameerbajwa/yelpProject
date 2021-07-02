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
    
//    var locationManager: CLLocationManager!
    var currentLatitude: CLLocationDegrees = 37.821950
    var currentLongitude: CLLocationDegrees = -121.976690
    
    var searchBusinessLabel = UILabel()
    var businessSearchBar = UISearchBar()
    
    var autocompleteViewModel = AutcompleteViewModel()
    
    var searchTableView = UITableView()
    
    var searchTerm: String?
    var selectedBusinessId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LocationManager.sharedInstance.getUserLocation { (location) in
//            print(location.coordinate.latitude)
//            print(location.coordinate.longitude)
//            self.currentLatitude = location.coordinate.latitude
//            self.currentLongitude = location.coordinate.longitude
//        }
        
        businessSearchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        setUpScreen()
        
    }
    
    // MARK: - Setting UI elements on screen
    
    func setUpScreen() {
        
        businessSearchBar.placeholder = "Search..."
        
        self.view.addSubview(businessSearchBar)
        businessSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBusinessLabel.text = "Search local businesses near you!"
        searchBusinessLabel.font = UIFont.boldSystemFont(ofSize: 20)
        searchBusinessLabel.textAlignment = .center
        
        self.view.addSubview(searchBusinessLabel)
        searchBusinessLabel.translatesAutoresizingMaskIntoConstraints = false
        
        searchBusinessLabel.isHidden = false
        
        self.view.addSubview(searchTableView)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        
        searchTableView.isHidden = true
        
        NSLayoutConstraint.activate([
            businessSearchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            businessSearchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            businessSearchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            
            searchBusinessLabel.topAnchor.constraint(equalTo: businessSearchBar.bottomAnchor, constant: 20.0),
            searchBusinessLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            searchTableView.topAnchor.constraint(equalTo: businessSearchBar.bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Service API Calls
    
    func callGetAutocomplete(searchText: String) {
        
        YelpService.sharedInstance.getAutocomplete(searchText: searchText, latitude: currentLatitude, longitude: currentLongitude, onSuccess: { (autocomplete) in
            self.autocompleteViewModel.autocompleteTermsList = autocomplete.terms.map(AutocompleteTermViewModel.init)
            self.autocompleteViewModel.autocompleteBusinessList = autocomplete.businesses.map(AutocompleteBusinessViewModel.init)
            
            print(self.autocompleteViewModel.autocompleteTermsList)
            
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
            
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "businessListSegue" {
            let vc = segue.destination as! BusinessListController
            vc.searchTerm = searchTerm
        } else if segue.identifier == "businessMapSegue" {
            let vc = segue.destination as! BusinessMapController
            vc.selectedBusinessId = selectedBusinessId
        }
    }

}

// MARK: - Search bar delegate functions

extension SearchBusinessesController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        DispatchQueue.main.async {
            self.searchTableView.isHidden = false
            self.searchBusinessLabel.isHidden = true
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        callGetAutocomplete(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text
        self.performSegue(withIdentifier: "businessListSegue", sender: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async {
            self.searchTableView.isHidden = true
            self.searchBusinessLabel.isHidden = false
        }
    }
    
}

// MARK: - Table view delegate functions

extension SearchBusinessesController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if autocompleteViewModel.autocompleteBusinessList.count > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return autocompleteViewModel.autocompleteTermsList.count
        } else {
            return autocompleteViewModel.autocompleteBusinessList.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Terms"
        } else {
            return "Businesses"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.section == 0 {
            cell.textLabel?.text = autocompleteViewModel.autocompleteTermsList[indexPath.row].term
        } else {
            cell.textLabel?.text = autocompleteViewModel.autocompleteBusinessList[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 0 {
            self.searchTerm = autocompleteViewModel.autocompleteTermsList[indexPath.row].term
            self.performSegue(withIdentifier: "businessListSegue", sender: nil)
        } else {
            self.selectedBusinessId = autocompleteViewModel.autocompleteBusinessList[indexPath.row].id
            self.performSegue(withIdentifier: "businessMapSegue", sender: nil)
        }
    }
    
}


