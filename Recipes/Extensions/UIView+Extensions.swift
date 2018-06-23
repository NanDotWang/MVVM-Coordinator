//
//  UIView+Extensions.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Add subview with constraints
    func addSubview(_ subView: UIView, constraints: [NSLayoutConstraint]) {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
