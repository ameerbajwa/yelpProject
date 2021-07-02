//
//  BusinessListController.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class BusinessListController: UITableViewController {

    var searchTerm: String?
    
    var businessListViewModel = BusinessListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(BusinessListCell.self, forCellReuseIdentifier: "businessListCell")
        
        if let safeSearchTerm = searchTerm {
            YelpService.sharedInstance.getBusinessList(searchText: safeSearchTerm, onSuccess: { (businesses) in
                self.businessListViewModel.businessList = businesses.businesses.map(BusinessViewModel.init)
                
                print(self.businessListViewModel.businessList)
                
                DispatchQueue.main.async {
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
        cell?.businessViewModel = businessListViewModel.businessList[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
