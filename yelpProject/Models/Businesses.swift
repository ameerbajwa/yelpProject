//
//  Businesses.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 6/30/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

struct Businesses: Codable {
    var total: Int
    var businesses: [Business]
}

struct Business: Codable {
    var rating: Double
    var price: String?
    var phone: String
    var id: String
    var categories: [Category]
    var review_count: Int
    var name: String
    var url: String
    var coordinates: BusinessCoordinates
    var image_url: String
    var location: BusinessLocation
}

struct Category: Codable {
    var alias: String
    var title: String
}

struct BusinessCoordinates: Codable {
    var latitude: Double
    var longitude: Double
}

struct BusinessLocation: Codable {
    var city: String
    var country: String
    var address1: String
    var address2: String?
    var address3: String?
    var state: String
    var zip_code: String
}
