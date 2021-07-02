//
//  BusinessListCell.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class BusinessListCell: UITableViewCell {

    var businessImageView = UIImageView()
    var businessNameLabel = UILabel()
    var businessAddressLabel = UILabel()
    var businessRatingLabel = UILabel()
    var businessPriceLabel = UILabel()
    var businessPhoneNumberLabel = UILabel()
    
    var ratingPriceStackView = UIStackView()
    
    var businessViewModel: BusinessViewModel! {
        didSet {
            businessNameLabel.text = businessViewModel.name
            businessAddressLabel.text = businessViewModel.address
            businessPhoneNumberLabel.text = businessViewModel.phone
            businessRatingLabel.text = businessViewModel.rating
            businessPriceLabel.text = businessViewModel.price
            businessImageView.image = UIImage(data: businessViewModel.setImage(stringUrl: businessViewModel.imageUrl)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        cellSetUp()
    }
    
    func cellSetUp() {
        
        self.contentView.addSubview(businessImageView)
        businessImageView.translatesAutoresizingMaskIntoConstraints = false
        
        businessNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        businessNameLabel.numberOfLines = 0
        
        self.contentView.addSubview(businessNameLabel)
        businessNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        businessAddressLabel.font = UIFont.systemFont(ofSize: 14)
        businessAddressLabel.textColor = .darkGray
        businessAddressLabel.numberOfLines = 0
        
        self.contentView.addSubview(businessAddressLabel)
        businessAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        businessPhoneNumberLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.contentView.addSubview(businessPhoneNumberLabel)
        businessPhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        businessRatingLabel.font = UIFont.systemFont(ofSize: 14)
        businessPriceLabel.font = UIFont.systemFont(ofSize: 14)
        
        ratingPriceStackView.axis = .horizontal
        ratingPriceStackView.spacing = 5.0
        ratingPriceStackView.distribution = .fillEqually
        
        ratingPriceStackView.addArrangedSubview(businessRatingLabel)
        ratingPriceStackView.addArrangedSubview(businessPriceLabel)
        
        self.contentView.addSubview(ratingPriceStackView)
        ratingPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            businessImageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            businessImageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            businessImageView.trailingAnchor.constraint(equalTo: businessNameLabel.leadingAnchor, constant: -20.0),
            businessImageView.heightAnchor.constraint(equalToConstant: 75.0),
            businessImageView.widthAnchor.constraint(equalToConstant: 75.0),
            
            businessNameLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            businessNameLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
            
            businessAddressLabel.topAnchor.constraint(equalTo: businessNameLabel.bottomAnchor, constant: 5.0),
            businessAddressLabel.leadingAnchor.constraint(equalTo: businessImageView.trailingAnchor, constant: 20.0),
            businessAddressLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
            
            businessPhoneNumberLabel.topAnchor.constraint(equalTo: businessAddressLabel.bottomAnchor, constant: 5.0),
            businessPhoneNumberLabel.leadingAnchor.constraint(equalTo: businessImageView.trailingAnchor, constant: 20.0),
            businessPhoneNumberLabel.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
            
            ratingPriceStackView.topAnchor.constraint(equalTo: businessPhoneNumberLabel.bottomAnchor, constant: 5.0),
            ratingPriceStackView.leadingAnchor.constraint(equalTo: businessImageView.trailingAnchor, constant: 20.0),
            ratingPriceStackView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5.0),
            ratingPriceStackView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10.0)
        ])
        
    }

}
