//
//  BusinessView.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/2/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit

class BusinessView: UIView {
    
    var businessImageView = UIImageView()
    var businessNameLabel = UILabel()
    var businessAddressLabel = UILabel()
    var businessRatingLabel = UILabel()
    var businessPriceLabel = UILabel()
    var businessPhoneNumberLabel = UILabel()
    
    var ratingPriceStackView = UIStackView()
    
    var businessListItemViewModel: BusinessListItemViewModel! {
        didSet {
            businessNameLabel.text = businessListItemViewModel.name
            businessAddressLabel.text = businessListItemViewModel.address
            businessPhoneNumberLabel.text = businessListItemViewModel.phone
            businessRatingLabel.text = businessListItemViewModel.rating
            businessPriceLabel.text = businessListItemViewModel.price
            if businessListItemViewModel.imageUrl == "no image url" {
                businessImageView.image = UIImage(named: "noImageFound")
            } else {
                if let safeData = businessListItemViewModel.setImage(stringUrl: businessListItemViewModel.imageUrl) {
                    businessImageView.image = UIImage(data: safeData)
                }
            }
        }
    }
    
    func setUpConstraints() {
        businessImageView.sizeToFit()
        
        self.addSubview(businessImageView)
        businessImageView.translatesAutoresizingMaskIntoConstraints = false
        
        businessNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        businessNameLabel.numberOfLines = 0
        
        self.addSubview(businessNameLabel)
        businessNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        businessAddressLabel.font = UIFont.systemFont(ofSize: 14)
        businessAddressLabel.textColor = .darkGray
        businessAddressLabel.numberOfLines = 0
        
        self.addSubview(businessAddressLabel)
        businessAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        businessPhoneNumberLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(businessPhoneNumberLabel)
        businessPhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        businessRatingLabel.font = UIFont.systemFont(ofSize: 14)
        businessPriceLabel.font = UIFont.systemFont(ofSize: 14)
        
        ratingPriceStackView.axis = .horizontal
        ratingPriceStackView.spacing = 5.0
        ratingPriceStackView.distribution = .fillEqually
        
        ratingPriceStackView.addArrangedSubview(businessRatingLabel)
        ratingPriceStackView.addArrangedSubview(businessPriceLabel)
        
        self.addSubview(ratingPriceStackView)
        ratingPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            businessImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
            businessImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            businessImageView.trailingAnchor.constraint(equalTo: businessNameLabel.leadingAnchor, constant: -20.0),
            businessImageView.heightAnchor.constraint(equalToConstant: 75.0),
            businessImageView.widthAnchor.constraint(equalToConstant: 75.0),
            
            businessNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
            businessNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
            
            businessAddressLabel.topAnchor.constraint(equalTo: businessNameLabel.bottomAnchor, constant: 5.0),
            businessAddressLabel.leadingAnchor.constraint(equalTo: businessImageView.trailingAnchor, constant: 20.0),
            businessAddressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
            
            businessPhoneNumberLabel.topAnchor.constraint(equalTo: businessAddressLabel.bottomAnchor, constant: 5.0),
            businessPhoneNumberLabel.leadingAnchor.constraint(equalTo: businessImageView.trailingAnchor, constant: 20.0),
            businessPhoneNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
            
            ratingPriceStackView.topAnchor.constraint(equalTo: businessPhoneNumberLabel.bottomAnchor, constant: 5.0),
            ratingPriceStackView.leadingAnchor.constraint(equalTo: businessImageView.trailingAnchor, constant: 20.0),
            ratingPriceStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
            ratingPriceStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0)
        ])
    }
}
