//
//  AutocompleteViewModel.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation

struct AutcompleteViewModel {
    
    var autocompleteTermsList: [AutocompleteTermViewModel]
    var autocompleteBusinessList: [AutocompleteBusinessViewModel]
    
    init() {
        self.autocompleteTermsList = [AutocompleteTermViewModel]()
        self.autocompleteBusinessList = [AutocompleteBusinessViewModel]()
    }
    
}

struct AutocompleteTermViewModel {
    let autocompleteTerm: AutocompleteTerm
    
    var term: String {
        return autocompleteTerm.text
    }
}

struct AutocompleteBusinessViewModel {
    let autocompleteBusiness: AutocompleteBusiness
    
    var id: String {
        return autocompleteBusiness.id
    }
    
    var name: String {
        return autocompleteBusiness.name
    }
}
