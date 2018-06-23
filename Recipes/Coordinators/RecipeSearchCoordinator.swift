//
//  RecipeSearchCoordinator.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-22.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit
import SafariServices

final class RecipeSearchCoordinator {
    
    private let apiService = APIService()
    
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: recipeSearchViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()
    
    private lazy var recipeSearchViewController: RecipeSearchViewController = {
        let dataProvider = RecipeSearchDataProvider(with: apiService)
        let recipeSearchViewController = RecipeSearchViewController(with: dataProvider)
        recipeSearchViewController.delegate = self
        return recipeSearchViewController
    }()
}

extension RecipeSearchCoordinator: RecipeSearchViewControllerDelegate {
    
    func recipeSearchViewController(_ recipeSearchViewController: RecipeSearchViewController, didSelectRecipe recipePreview: RecipePreview) {
        let dataProvider = RecipeDetailDataProvider(with: apiService, recipePreview: recipePreview)
        let recipeDetailViewController = RecipeDetailViewController(with: dataProvider)
        recipeDetailViewController.delegate = self
        navigationController.pushViewController(recipeDetailViewController, animated: true)
    }
}

extension RecipeSearchCoordinator: RecipeDetailViewControllerDelegate {
    
    func recipeDetailViewController(_ recipeDetailViewController: RecipeDetailViewController, shouldOpenUrl url: URL?) {
        
        guard let url = url else {
            navigationController.showSimpleAlertWithMessage("⚠️ Invalid url")
            return
        }
        
        let safariViewController = SFSafariViewController(url: url)
        navigationController.present(safariViewController, animated: true, completion: nil)
    }
}
