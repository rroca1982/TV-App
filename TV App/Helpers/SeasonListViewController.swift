//
//  SeasonListViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class SeasonListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var noResultsLabel: UILabel!

    // MARK: - Properties
    var showID: Int!
    
    private var datasource: TableViewDataSource<SimpleTableViewCell, SeasonListViewModel>!
    private let viewModel = SeasonListViewModel(service: ShowsService())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Seasons".localized()

        navigationController?.navigationBar.setPrimaryLargeTitleAppearance()
        
        datasource = TableViewDataSource<SimpleTableViewCell, SeasonListViewModel>(viewModel: viewModel, tableView: tableView) { cell, model in
            let title = "Season \(model.number)"
            let cellViewModel = SimpleTableViewCellViewModel(model: title)
            cell.update(with: cellViewModel)
        }
        
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: .zero)
                
        getData()
    }
    
    func getData() {
        activityIndicator.startAnimating()
        hideNoResultsLabel()

        viewModel.fetchSeasons(showID: showID) { [weak self] (result) in
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
                        if self?.viewModel.items.count == 0 {
                            self?.showNoResultsLabel()
                        }
                        ErrorHandler.sharedInstance.handleError(error, from: strongSelf)
                    }
                }
            }
        }
    }
    
    // MARK: - Helper methods
    func showNoResultsLabel() {
        tableView.isHidden = true
        noResultsLabel.isHidden = false
    }
    
    func hideNoResultsLabel() {
        noResultsLabel.isHidden = true
        tableView.isHidden = false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.episodeListFromSeason.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! EpisodeListViewController
                    destination.season = viewModel.items[indexPath.row]
            }
        }
    }
}

extension SeasonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .episodeListFromSeason, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SegueHandlerType conformance
extension SeasonListViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case episodeListFromSeason
    }
}
