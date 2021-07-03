//
//  Loader.swift
//  yelpProject
//
//  Created by Ameer Bajwa on 7/3/21.
//  Copyright © 2021 Ameer Bajwa. All rights reserved.
//

import Foundation
import UIKit

class SpinnerView: UIView {
    var spinner = UIActivityIndicatorView()
    var spinnerContainerView = UIView()

    func createSpinnerView(view: UIView) {
        
        spinnerContainerView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        spinnerContainerView.layer.cornerRadius = 10.0
        
        spinner.style = UIActivityIndicatorView.Style.large
        spinner.color = UIColor.black
        spinner.startAnimating()
        
        spinnerContainerView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(spinnerContainerView)
        spinnerContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: spinnerContainerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: spinnerContainerView.centerYAnchor),
            
            spinnerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinnerContainerView.widthAnchor.constraint(equalToConstant: 80.0),
            spinnerContainerView.heightAnchor.constraint(equalToConstant: 80.0)
            
        ])

    }
    
    func dismissSpinnerView() {
        spinnerContainerView.removeFromSuperview()
        spinner.removeFromSuperview()
    }
    
}
