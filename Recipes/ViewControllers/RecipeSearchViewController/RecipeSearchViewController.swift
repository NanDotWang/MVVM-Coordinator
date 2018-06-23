//
//  RecipeSearchViewController.swift
//  Recipes
//
//  Created by Nan Wang on 2018-06-21.
//  Copyright © 2018 Nan. All rights reserved.
//

import UIKit

protocol RecipeSearchViewControllerDelegate: class {
    
    /// Tell the delegate user has selected this recipe
    func recipeSearchViewController(_ recipeSearchViewController: RecipeSearchViewController, didSelectRecipe recipePreview: RecipePreview)
}

final class RecipeSearchViewController: UITableViewController {
    
    weak var delegate: RecipeSearchViewControllerDelegate?
    
    private let dataProvider: RecipeSearchDataProvider
    
    private let loadingViewController = UIViewController.loading
    
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
        add(loadingViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Recipes".localized
        view.backgroundColor = .groupTableViewBackground
        
        // Don't show empty cells on the bottom
        tableView.tableFooterView = UIView()
        
        // Set `self` as the `UISearchResultsUpdating` delegate of search controller
        searchController.searchResultsUpdater = self
    }
}

// MARK: - UISearchResultsUpdating
extension RecipeSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let query = searchController.searchBar.text,
            !query.isEmpty
            else { return }
        
        dataProvider.searchRecipes(query: query)
    }
}

//MARK: - TableView DataSource
extension RecipeSearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: cellReuseIdentifier)
            cell.accessoryType = .disclosureIndicator
            configure(cell, for: indexPath)
            return cell
        }
        
        configure(cell, for: indexPath)
        return cell
    }
    
    private func configure(_ cell: UITableViewCell, for indexPath: IndexPath) {
        let recipePreview = dataProvider.data(for: indexPath)
        cell.textLabel?.text = recipePreview.title
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

// MARK: - RecipeSearchDataProviderDelegate
extension RecipeSearchViewController: RecipeSearchDataProviderDelegate {
    
    func recipeSearchDataProviderDidUpdateData(_ recipeSearchDataProvider: RecipeSearchDataProvider) {
        loadingViewController.remove()
        tableView.reloadData()
    }
}
