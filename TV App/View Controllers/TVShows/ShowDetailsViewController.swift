//
//  ShowDetailsViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var scollView: UIScrollView!
    @IBOutlet private weak var posterHoldingView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var tvShowTitleLabel: UILabel!
    @IBOutlet private weak var runtimeLabel: UILabel!
    @IBOutlet private weak var summaryTextLabel: UILabel!
    @IBOutlet private weak var daysLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var buttonContainer: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var tvShow: Show!
    
    private var viewModel: ShowDetailsViewModel?
    private var datasource: CollectionViewDataSource<GenreCollectionViewCell, GenresViewModel>!
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Show Details".localized()
        
        navigationItem.largeTitleDisplayMode = .never
        
        viewModel = ShowDetailsViewModel(model: tvShow)
        
        let posterCornerRadius = CGFloat(6.0)
        posterHoldingView.addDefaultPosterShadow()
        posterImageView.layer.cornerRadius = posterCornerRadius
        buttonContainer.addDefaultDropShadow()
        setupGenresCollectionView()
        setupTVShowDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = collectionView.contentSize.height
        collectionViewHeightConstraint.constant = size
    }
    
    // MARK: - Setup
    fileprivate func setupTVShowDetails() {
        guard let viewModel = viewModel else {
            return
        }
        activityIndicator.startAnimating()
        scollView.isHidden = true
        buttonContainer.isHidden = true
        
        DispatchQueue.main.async { [weak self] in
            self?.summaryTextLabel.text = viewModel.summary?.withoutHtml
            self?.activityIndicator.stopAnimating()
            self?.scollView.isHidden = false
            self?.buttonContainer.isHidden = false
        }
        
        tvShowTitleLabel.text = viewModel.tvShowTitle
        
        if let posterImageURL = viewModel.posterImageURL {
            posterImageView.setImage(withURL: posterImageURL.absoluteString, placeholderImage: viewModel.posterPlaceholderImage!)
        } else {
            posterImageView.image = viewModel.posterPlaceholderImage
        }
        
        runtimeLabel.text = viewModel.runtime
        
        timeLabel.text = viewModel.time
        daysLabel.text = viewModel.days
    }
    
    fileprivate func setupGenresCollectionView() {
        
        let genresViewModel = GenresViewModel()
        genresViewModel.addItems(tvShow.genres)
        
        datasource = CollectionViewDataSource<GenreCollectionViewCell, GenresViewModel>(viewModel: genresViewModel, collectionView: collectionView) { cell, model in
            let cellViewModel = GenreCollectionCellViewModel(model: model)
            cell.update(with: cellViewModel)
        }
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
    
    // MARK: - Button Actions
    @IBAction func episodeGuideButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: .seasonsListFromShowDetails, sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.seasonsListFromShowDetails.rawValue {
            let destination = segue.destination as! SeasonListViewController
            destination.showID = tvShow.id
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension ShowDetailsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewModel = GenreCollectionCellViewModel.init(model: tvShow.genres[indexPath.row])
        let size: CGSize = viewModel.name.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)])
        return CGSize(width: size.width + 35.0, height: 25)
    }
}

// MARK: - SegueHandlerType conformance
extension ShowDetailsViewController: SegueHandlerType {
    
    enum SegueIdentifier: String {
        case seasonsListFromShowDetails
    }
}
