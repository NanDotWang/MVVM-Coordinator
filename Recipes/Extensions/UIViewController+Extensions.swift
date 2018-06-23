//
//  UIViewController+Extensions.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// A loading view controller
    static var loading: UIViewController {
        let viewController = UIViewController()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.startAnimating()
        
        viewController.view.addSubview(indicator, constraints: [
            indicator.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: -150)
            ])
        
        return viewController
    }
    
    /// Add child view controller
    func add(_ child: UIViewController) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    /// Remove self from parent view controller
    func remove() {
        guard parent != nil else { return }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
    
    /// Simply show an alert message from current view controller
    func showSimpleAlertWithMessage(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
