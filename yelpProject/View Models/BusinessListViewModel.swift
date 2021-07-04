//
//  BusinessListViewModel.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation
import CoreLocation

struct BusinessListViewModel {
    var businessList: [BusinessListItemViewModel]
    
    init() {
        self.businessList = [BusinessListItemViewModel]()
    }
    
}

struct BusinessListItemViewModel {
    var business: BusinessListItem
    
    init(business: BusinessListItem) {
        self.business = business
    }
    
    var id: String {
        if let safeId = business.id {
            return safeId
        } else {
            return "-"
        }
    }
    
    var name: String {
        if let safeName = business.name {
            return safeName
        } else {
            return "Business Name: -"
        }
    }
    
    var phone: String {
        if let safePhone = business.phone {
            return safePhone
        } else {
            return "No Phone Number"
        }
    }
    
    var rating: String {
        if let safeRating = business.rating {
            return "Rating: \(safeRating)"
        } else {
            return "Rating: -"
        }
    }
    
    var price: String {
        return "Price: \(business.price ?? "-")"
    }
    
    var address: String {
        var formingAddress: String = ""
        formingAddress = "\(business.location?.address1 ?? "-") "
        if let address2 = business.location?.address2 {
            if address2 != "" {
                formingAddress.append(contentsOf: "\(address2) ")
            }
        }
        if let address3 = business.location?.address3 {
            if address3 != "" {
                formingAddress.append(contentsOf: "\(address3) ")
            }
        }
        if let safeCity = business.location?.city {
            formingAddress.append(contentsOf: safeCity)
        }
        if let safeState = business.location?.state {
            formingAddress.append(contentsOf: " \(safeState)")
        }
        if let safeZip = business.location?.zip_code {
            formingAddress.append(contentsOf: " \(safeZip)")
        }
        return formingAddress
    }
    
    var location: CLLocationCoordinate2D {
        if let lat = business.coordinates?.latitude, let lon = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        } else {
            return CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
    var imageUrl: String {
        if let safeImageUrl = business.image_url {
            return safeImageUrl
        } else {
            return "no image url"
        }
    }
    
    func setImage(stringUrl: String) -> Data? {
        guard let imageURL = URL(string: stringUrl) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }

        return imageData
    }
}
