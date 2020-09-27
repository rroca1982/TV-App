//
//  SearchViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    enum SearchType {
        case show
        case people
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var segmentedControl: TVAppSegmentedControl!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var noResultsLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var isSearching = false
    private var searchType: SearchType = .show
    
    private var viewModel = ShowListViewModel(service: SearchService())
    private var datasource: TableViewDataSource<ShowListTableViewCell, ShowListViewModel>!
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search".localized()
        
        navigationController?.navigationBar.setPrimaryLargeTitleAppearance()
        extendedLayoutIncludesOpaqueBars = true
        
        datasource = TableViewDataSource<ShowListTableViewCell, ShowListViewModel>(viewModel: viewModel, tableView: tableView) { cell, model in
            let cellViewModel = ShowListTableViewCellViewModel(model: model)
            cell.update(with: cellViewModel)
        }
        
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        setupSearchBarController()
        showNoResultsLabel()
    }
    
    // MARK: - Setup
    fileprivate func setupSearchBarController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "TV Shows by their title".localized()
        searchBar.searchBarStyle = .default
        searchBar.searchTextField.backgroundColor = .white
        searchBar.tintColor = UIColor.white
        
        searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    // MARK: - Search methods
    func search(searchTerm: String) {
        isSearching = true

        viewModel.removeAllItems()

        hideNoResultsLabel()
        
        activityIndicator.startAnimating()
        
        switch searchType {
        case .show:
            searchShows(searchTerm)
        case .people:
            searchShows(searchTerm)
        }
    }
    
    @objc func clearSearch() {
        isSearching = false
        
        viewModel.removeAllItems()
        tableView.reloadData()

        showNoResultsLabel()
    }
    
    // MARK: - Data Fetch
    fileprivate func searchShows(_ searchTerm: String) {
        viewModel.searchShows(title: searchTerm) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case .Success:
                    if self?.viewModel.items.count == 0 {
                        self?.showNoResultsLabel()
                    } else {
                        self?.tableView.reloadData()
                    }
                case.Failure(let error):
                    if let strongSelf = self {
                        ErrorHandler.sharedInstance.handleError(error, from: strongSelf)
                    }
                }
            }
        }
    }
    
    fileprivate func searchPeople(_ searchTerm: String) {
        viewModel.searchShows(title: searchTerm) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case .Success:
                    if self?.viewModel.items.count == 0 {
                        self?.showNoResultsLabel()
                    } else {
                        self?.tableView.reloadData()
                    }
                case.Failure(let error):
                    if let strongSelf = self {
                        ErrorHandler.sharedInstance.handleError(error, from: strongSelf)
                    }
                }
            }
        }
    }
    
    // MARK: - Button Actions
    @IBAction func segmentedControlValueChanged(_ sender: TVAppSegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            searchType = .show
        } else {
            searchType = .people
        }
    }
    
    // MARK: - Helper methods
    func showNoResultsLabel() {
        tableView.isHidden = true
        noResultsLabel.isHidden = false
        
        updateNoResultsLabelText()
    }
    
    func hideNoResultsLabel() {
        noResultsLabel.isHidden = true
        tableView.isHidden = false
    }
    
    fileprivate func updateNoResultsLabelText() {
        if isSearching {
            noResultsLabel.text = "No results found".localized()
        } else {
            noResultsLabel.text = "Search for TV Shows by its' title.".localized()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showDetailsFromSearch.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! ShowDetailsViewController
                    destination.tvShow = viewModel.items[indexPath.row]
            }
        }
    }
}

// MARK: - SearchBar Delegates
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }

        if text != "" {
            search(searchTerm: text)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
    }
}

// MARK: - TableView Delegate
extension SearchViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .showDetailsFromSearch, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SegueHandlerType conformance
extension SearchViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case showDetailsFromSearch
    }
}
