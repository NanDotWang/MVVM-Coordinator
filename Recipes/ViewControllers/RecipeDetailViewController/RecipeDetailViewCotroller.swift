//
//  RecipeDetailViewCotroller.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-23.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

protocol RecipeDetailViewControllerDelegate: class {
    func recipeDetailViewController(_ recipeDetailViewController: RecipeDetailViewController, shouldOpenUrl url: URL?)
}

final class RecipeDetailViewController: UITableViewController {
    
    weak var delegate: RecipeDetailViewControllerDelegate?
    
    private let dataProvider: RecipeDetailDataProvider
    
    private let loadingViewController = UIViewController.loading
    
    private let cellReuseIdentifier = "RecipeDetailCell"
    
    private let headerView = RecipeHeaderView()
    
    private lazy var footerView: RecipeFooterView = {
        guard let footerView = Bundle.main.loadNibNamed("RecipeFooterView", owner: self, options: nil)?.first as? RecipeFooterView else {
            preconditionFailure("⚠️ Can not load recipe footer view from nib")
        }
        footerView.delegate = self
        return footerView
    }()
    
    init(with dataProvider: RecipeDetailDataProvider) {
        self.dataProvider = dataProvider
        super.init(style: .plain)
        
        dataProvider.delegate = self
        dataProvider.loadRecipeDetail()
        add(loadingViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .groupTableViewBackground
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.tableHeaderView = headerView
        
        // Don't show empty cells on the bottom
        tableView.tableFooterView = UIView()
    }
}

//MARK: - TableView DataSource
extension RecipeDetailViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ingredients:".localized
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let ingredientString = dataProvider.data(for: indexPath)
        
        cell.textLabel?.text = ingredientString
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - RecipeDetailDataProviderDelegate
extension RecipeDetailViewController: RecipeDetailDataProviderDelegate {
    
    func RecipeDetailDataProviderDidUpdateData(_ recipeDetailDataProvider: RecipeDetailDataProvider) {
        loadingViewController.remove()
        tableView.reloadData()

        title = dataProvider.recipeName
        
        headerView.loadImage(with: dataProvider.recipeHeaderImageUrl, apiService: dataProvider.apiService)
        footerView.configure(publisherName: dataProvider.publisherName, socialRank: dataProvider.socialRank)
        tableView.tableFooterView = footerView
    }
}

//MARK: - RecipeFooterViewDelegate
extension RecipeDetailViewController: RecipeFooterViewDelegate {
    
    func recipeFooterViewDidTapShowInstructions(_ recipeFooterView: RecipeFooterView) {
        delegate?.recipeDetailViewController(self, shouldOpenUrl: dataProvider.instructionsUrl)
    }
    
    func recipeFooterViewDidTapShowOriginal(_ recipeFooterView: RecipeFooterView) {
        delegate?.recipeDetailViewController(self, shouldOpenUrl: dataProvider.originalUrl)
    }
}
