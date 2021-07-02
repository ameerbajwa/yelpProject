//
//  BusinessListViewModel.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

struct BusinessListViewModel {
    var businessList: [BusinessViewModel]
    
    init() {
        self.businessList = [BusinessViewModel]()
    }
    
}

struct BusinessViewModel {
    let business: Business
    
    var id: String {
        return business.id
    }
    
    var name: String {
        return business.name
    }
    
    var phone: String {
        return business.phone
    }
    
    var rating: String {
        return "Rating: \(business.rating)"
    }
    
    var price: String {
        return "Price: \(business.price ?? "-")"
    }
    
    var address: String {
        var formingAddress: String = ""
        formingAddress = business.location.address1
        if let address2 = business.location.address2 {
            formingAddress.append(contentsOf: " \(address2)")
        }
        if let address3 = business.location.address3 {
            formingAddress.append(contentsOf: " \(address3)")
        }
        formingAddress.append(contentsOf: " \(business.location.city) \(business.location.state) \(business.location.zip_code)")
        return formingAddress
    }
    
    var latitude: Double {
        return business.coordinates.latitude
    }
    
    var longitude: Double {
        return business.coordinates.longitude
    }
    
    var imageUrl: String {
        return business.image_url
    }
    
    func setImage(stringUrl: String) -> Data? {
        guard let imageURL = URL(string: stringUrl) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }

        return imageData
    }
}
