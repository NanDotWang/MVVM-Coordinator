//
//  RecipeFooterView.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

protocol RecipeFooterViewDelegate: class {
    func recipeFooterViewDidTapShowInstructions(_ recipeFooterView: RecipeFooterView)
    func recipeFooterViewDidTapShowOriginal(_ recipeFooterView: RecipeFooterView)
}

class RecipeFooterView: UIView {
    
    weak var delegate: RecipeFooterViewDelegate?
    
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var socialRankLabel: UILabel!
    
    @IBAction func showInstructions() {
        delegate?.recipeFooterViewDidTapShowInstructions(self)
    }
    
    @IBAction func showOriginal() {
        delegate?.recipeFooterViewDidTapShowOriginal(self)
    }
    
    func configure(publisherName: String, socialRank: Double) {
        publisherNameLabel.text = publisherName
        socialRankLabel.text = "Social rank: \(String(format: "%.1f", socialRank))"
    }
}
