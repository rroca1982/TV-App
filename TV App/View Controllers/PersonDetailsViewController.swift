//
//  PersonDetailsViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class PersonDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var infoStackHoldingView: UIView!
    @IBOutlet private weak var photoHoldingView: UIView!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var noResultsLabel: UILabel!

    // MARK: - Properties
    private var datasource: TableViewDataSource<ShowListTableViewCell, PersonDetailsViewModel>!
    private var viewModel: PersonDetailsViewModel?
    
    var person: Person!
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Person Details".localized()
        
        navigationItem.largeTitleDisplayMode = .never

        let posterCornerRadius = CGFloat(6.0)
        photoHoldingView.addDefaultPosterShadow()
        photoImageView.layer.cornerRadius = posterCornerRadius
        
        viewModel = PersonDetailsViewModel(service: PeopleService(), model: person)
        datasource = TableViewDataSource<ShowListTableViewCell, PersonDetailsViewModel>(viewModel: viewModel!, tableView: tableView) { cell, model in
            let cellViewModel = ShowListTableViewCellViewModel(model: model)
            cell.update(with: cellViewModel)
        }
        
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        hideNoResultsLabel()
        
        setupPersonDetails()
    }
    
    // MARK: - Setup
    func setupPersonDetails() {
        guard let viewModel = viewModel else {
            return
        }
        
        nameLabel.text = viewModel.name
        
        if let posterImageURL = viewModel.photoURL {
            photoImageView.setImage(withURL: posterImageURL.absoluteString, placeholderImage: viewModel.photoPlaceholder!)
        } else {
            photoImageView.image = viewModel.photoPlaceholder
        }
        
        getData()
    }
    
    // MARK: - Data Fetch
    func getData() {
        guard let viewModel = viewModel else {
            return
        }
        
        activityIndicator.startAnimating()
        hideNoResultsLabel()
        
        viewModel.fetchCastCredits(personID: person.id) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()

                switch result {
                case .Success:
                    self?.tableView.reloadData()
                    if viewModel.items.count == 0 {
                        self?.showNoResultsLabel()
                    }
                case.Failure(let error):
                    if let strongSelf = self {
                        if viewModel.items.count == 0 {
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
        if segue.identifier == SegueIdentifier.showDetailsFromPerson.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow, let viewModel = viewModel {
                let destination = segue.destination as! ShowDetailsViewController
                    destination.tvShow = viewModel.items[indexPath.row]
            }
        }
    }
}

// MARK: - TableView Delegate
extension PersonDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .showDetailsFromPerson, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SegueHandlerType conformance
extension PersonDetailsViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case showDetailsFromPerson
    }
}
