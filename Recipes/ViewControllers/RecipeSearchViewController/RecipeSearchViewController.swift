//
//  RecipeSearchViewController.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit
import CacheKit

protocol RecipeSearchViewControllerDelegate: class {
    
    func recipeSearchViewController(_ recipeSearchViewController: RecipeSearchViewController, didSelectRecipe recipePreview: RecipePreview)
}

class RecipeSearchViewController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: RecipeSearchViewControllerDelegate?
    
    private let dataProvider: RecipeSearchDataProvider
    
    /// UISearchController that we set into current navigation item
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search recipe".localized
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        return searchController
    }()
    
    /// Table view cell reuse identifier
    private let cellReuseIdentifier = "RecipeSearchCell"
    
    // MARK: - Init
    
    init(with dataProvider: RecipeSearchDataProvider) {
        self.dataProvider = dataProvider
        super.init(style: .plain)
        
        dataProvider.delegate = self
        dataProvider.loadTrendingRecipes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Recipes".localized
        view.backgroundColor = .groupTableViewBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // Don't show empty cells on the bottom
        tableView.tableFooterView = UIView()
        
        // Set `self` as the `UISearchResultsUpdating` delegate of search controller
        searchController.searchResultsUpdater = self
    }
}

// MARK: - UISearchResultsUpdating
extension RecipeSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: - RecipeSearchDataProviderDelegate

extension RecipeSearchViewController: RecipeSearchDataProviderDelegate {
    
    func recipeSearchDataProviderDidUpdateData(_ recipeSearchDataProvider: RecipeSearchDataProvider) {
        tableView.reloadData()
    }
}

//MARK: - TableView DataSource
extension RecipeSearchViewController {
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Top trending recipes".localized
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let recipePreview = dataProvider.data(for: indexPath)
        
        cell.textLabel?.text = recipePreview.title
        cell.setImage(with: URL(string: recipePreview.image_url)!)
        
        return cell
    }
}

//MARK: - TableView Delegate
extension RecipeSearchViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recipePreview = dataProvider.data(for: indexPath)
        delegate?.recipeSearchViewController(self, didSelectRecipe: recipePreview)
    }
}
