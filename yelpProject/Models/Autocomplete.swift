//
//  Autocomplete.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 6/30/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

struct Autocomplete: Codable {
    var terms: [AutocompleteTerm]
    var businesses: [AutocompleteBusiness]
    var categories: [Category]
}

struct AutocompleteTerm: Codable {
    var text: String
}

struct AutocompleteBusiness: Codable {
    var id: String
    var name: String
}

//struct AutocompleteCategory: Codable {
//    var alias: String
//    var title: String
//}
