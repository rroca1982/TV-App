//
//  ShowListViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class ShowListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var failedFetchView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var datasource: TableViewDataSource<ShowListTableViewCell, ShowListViewModel>!
    private let viewModel = ShowListViewModel(service: ShowsService())
        
    private var page = 0
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TV Shows".localized()

        navigationController?.navigationBar.setPrimaryLargeTitleAppearance()
        navigationItem.largeTitleDisplayMode = .always
        
        datasource = TableViewDataSource<ShowListTableViewCell, ShowListViewModel>(viewModel: viewModel, tableView: tableView) { cell, model in
            let cellViewModel = ShowListTableViewCellViewModel(model: model)
            cell.update(with: cellViewModel)
        }
        
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: .zero)

        page += 1
        getData()
    }
    
    // MARK: - Data Fetch
    func getData() {
        activityIndicator.startAnimating()
        
        viewModel.fetchShows(page: page) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()

                switch result {
                case .Success:
                    self?.tableView.reloadData()
                case.Failure(let error):
                    if let strongSelf = self {
                        if self?.viewModel.items.count == 0 {
                            self?.showFailedFetchView()
                        }
                        
                        guard let restError = error as? SwiftyRestKitError, !(restError == .resourceNotFound && strongSelf.viewModel.hasReachedLastPage) else {
                            return
                        }
                        
                        ErrorHandler.sharedInstance.handleError(error, from: strongSelf)
                    }
                }
            }
        }        
    }
    
    // MARK: - Button Actions
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        hideFailedFetchView()
        getData()
    }
    
    // MARK: - Helper Methods
    fileprivate func showFailedFetchView() {
        tableView.isHidden = true
        failedFetchView.isHidden = false
    }
    
    fileprivate func hideFailedFetchView() {
        failedFetchView.isHidden = true
        tableView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.showDetailsFromList.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! ShowDetailsViewController
                    destination.tvShow = viewModel.items[indexPath.row]
            }
        }
    }
}

// MARK: - TableView Delegate
extension ShowListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if !viewModel.hasReachedLastPage {
            if indexPath.item == viewModel.items.count - 1 {
                page += 1
                getData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .showDetailsFromList, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SegueHandlerType conformance
extension ShowListViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case showDetailsFromList
    }
}

