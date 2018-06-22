//
//  String+Extensions.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import Foundation

extension String {
    
    /// Get a localized version of current string value
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
