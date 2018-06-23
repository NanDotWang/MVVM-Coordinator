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
    
    private let loadingStateViewController = UIViewController.loading
    
    private let emptyStateViewController = UIViewController.noData
    
    /// Request token is used to cancel current search request
    private var requestToken: RequestToken?
    
    /// UISearchController that we set into current navigation item
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search recipe".localized
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        return searchController
    }()
    
    private lazy var headerView: SearchHeaderView = {
        let headerView = SearchHeaderView()
        headerView.configureHeader(.topTrending)
        return headerView
    }()
    
    /// Table view cell reuse identifier
    private let cellReuseIdentifier = "RecipeSearchCell"
    
    // MARK: - Init
    init(with dataProvider: RecipeSearchDataProvider) {
        self.dataProvider = dataProvider
        super.init(style: .plain)
        
        dataProvider.delegate = self
        dataProvider.loadTrendingRecipes()
        add(loadingStateViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Recipes".localized
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        view.backgroundColor = .white
        navigationItem.searchController = searchController
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

// MARK: - RecipeSearchDataProvider Delegate
extension RecipeSearchViewController: RecipeSearchDataProviderDelegate {
    
    func recipeSearchDataProvider(_ recipeSearchDataProvider: RecipeSearchDataProvider, didUpdateData data: [RecipePreview]) {

        /// Remove states view controllers
        loadingStateViewController.remove()
        emptyStateViewController.remove()
        
        if data.isEmpty {
            add(emptyStateViewController)
        }
        
        tableView.reloadData()
    }
}

// MARK: - UISearchBar Delegate
extension RecipeSearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        dataProvider.isSearching = true
        headerView.configureHeader(.searchResults)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        triggerSearch(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        triggerSearch(with: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataProvider.isSearching = false
        dataProvider.clearSearchResults()
        headerView.configureHeader(.topTrending)
    }
    
    private func triggerSearch(with keyword: String?) {
        /// Cancel ongoing search request
        requestToken?.cancel()
        
        guard
            let query = keyword,
            !query.isEmpty
            else {
                add(emptyStateViewController)
                return
        }

        requestToken = dataProvider.searchRecipes(query: query)
        add(loadingStateViewController)
    }
}
