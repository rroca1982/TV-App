//
//  EpisodeListViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var noResultsLabel: UILabel!
        
   // MARK: - Properties
    var season: Season!

    private var datasource: TableViewDataSource<SimpleTableViewCell, EpisodeListViewModel>!
    private let viewModel = EpisodeListViewModel(service: ShowsService())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episodes".localized()

        navigationController?.navigationBar.setPrimaryLargeTitleAppearance()
        
        datasource = TableViewDataSource<SimpleTableViewCell, EpisodeListViewModel>(viewModel: viewModel, tableView: tableView) { cell, model in
            var title = ""
            if let number = model.number {
                title = "Episode \(number)"
            } else {
                title = "Special Episode"
            }
            
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

        viewModel.fetchEpisodes(seasonID: season.id) { [weak self] (result) in
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
        if segue.identifier == SegueIdentifier.episodeDetailsFromList.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! EpisodeDetailsViewController
                    destination.episode = viewModel.items[indexPath.row]
            }
        }
    }
}

extension EpisodeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .episodeDetailsFromList, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SegueHandlerType conformance
extension EpisodeListViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case episodeDetailsFromList
    }
}
