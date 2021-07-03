//
//  BusinessListCell.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/1/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import UIKit

class BusinessListCell: UITableViewCell {

    let businessView = BusinessView()
    
    var businessListItemViewModel: BusinessListItemViewModel! {
        didSet {
            businessView.businessListItemViewModel = businessListItemViewModel
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
        businessView.setUpConstraints()
        self.contentView.addSubview(businessView)
        businessView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            businessView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
            businessView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor),
            businessView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor),
            businessView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
