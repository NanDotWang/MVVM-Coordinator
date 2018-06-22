//
//  AppDelegate.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow(frame: UIScreen.main.bounds)
    
    /// Recipe search coordinator
    private let recipeSearchCoordinator = RecipeSearchCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window.rootViewController = recipeSearchCoordinator.navigationController
        window.makeKeyAndVisible()

        return true
    }
}
