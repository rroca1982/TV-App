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
    
    private var showsViewModel = ShowListViewModel(service: SearchService())
    private var peopleViewModel = PersonListViewModel(service: SearchService())
    
    private var showDatasource: TableViewDataSource<ShowListTableViewCell, ShowListViewModel>!
    private var personDatasource: TableViewDataSource<PersonListTableViewCell, PersonListViewModel>!
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search".localized()
        
        navigationController?.navigationBar.setPrimaryLargeTitleAppearance()
        extendedLayoutIncludesOpaqueBars = true
        
        showDatasource = TableViewDataSource<ShowListTableViewCell, ShowListViewModel>(viewModel: showsViewModel, tableView: tableView) { cell, model in
            let cellViewModel = ShowListTableViewCellViewModel(model: model)
            cell.update(with: cellViewModel)
        }
        
        personDatasource = TableViewDataSource<PersonListTableViewCell, PersonListViewModel>(viewModel: peopleViewModel, tableView: tableView) { cell, model in
            let cellViewModel = PersonListTableViewCellViewModel(model: model)
            cell.update(with: cellViewModel)
        }
        
        tableView.dataSource = showDatasource
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
        searchBar.placeholder = "Search for TV Shows or people".localized()
        searchBar.searchBarStyle = .default
        searchBar.searchTextField.backgroundColor = .systemBackground
        searchBar.searchTextField.textColor = .darkGrayText
        searchBar.tintColor = .systemBackground
        
        searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    // MARK: - Search methods
    func search(searchTerm: String) {
        isSearching = true
        
        hideNoResultsLabel()
        
        activityIndicator.startAnimating()
        
        switch searchType {
        case .show:
            showsViewModel.removeAllItems()
            searchShows(searchTerm)
        case .people:
            peopleViewModel.removeAllItems()
            searchPeople(searchTerm)
        }
    }
    
    @objc func clearSearch() {
        isSearching = false
        
        switch searchType {
        case .show:
            showsViewModel.removeAllItems()
            tableView.dataSource = showDatasource
        case .people:
            peopleViewModel.removeAllItems()
            tableView.dataSource = personDatasource
        }
        tableView.reloadData()

        showNoResultsLabel()
    }
    
    // MARK: - Data Fetch
    fileprivate func searchShows(_ searchTerm: String) {
        showsViewModel.searchShows(title: searchTerm) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case .Success:
                    if self?.showsViewModel.items.count == 0 {
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
        peopleViewModel.searchPerson(name: searchTerm) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                switch result {
                case .Success:
                    if self?.peopleViewModel.items.count == 0 {
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
            tableView.dataSource = showDatasource
        } else {
            searchType = .people
            tableView.dataSource = personDatasource
        }
        tableView.reloadData()
        updateNoResultsLabelText()
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
            switch searchType {
            case .show:
                noResultsLabel.text = "Search for TV Shows by its' title.".localized()
            case .people:
                noResultsLabel.text = "Search for people by name.".localized()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showDetailsFromSearch.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! ShowDetailsViewController
                    destination.tvShow = showsViewModel.items[indexPath.row]
            }
        } else if segue.identifier == SegueIdentifier.personDetailsFromSearch.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! PersonDetailsViewController
                destination.person = peopleViewModel.items[indexPath.row]
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
        
        switch searchType {
        case .show:
            performSegue(withIdentifier: .showDetailsFromSearch, sender: self)
        case .people:
            performSegue(withIdentifier: .personDetailsFromSearch, sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SegueHandlerType conformance
extension SearchViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case showDetailsFromSearch
        case personDetailsFromSearch
    }
}
