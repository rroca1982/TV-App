//
//  EpisodeDetailsViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var scollView: UIScrollView!
    @IBOutlet private weak var episodeImageView: UIImageView!
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    @IBOutlet private weak var seasonEpisodeNumberLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    var episode: Episode!
    
    private var viewModel: EpisodeDetailsViewModel?
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Episode Details".localized()
        
        viewModel = EpisodeDetailsViewModel(model: episode)
        
        setupEpisodeDetails()
    }
    
    // MARK: - Setup
    fileprivate func setupEpisodeDetails() {
        guard let viewModel = viewModel else {
            return
        }
        
        activityIndicator.startAnimating()
        scollView.isHidden = true
        DispatchQueue.main.async { [weak self] in
            self?.summaryLabel.text = viewModel.summary.withoutHtml
            self?.activityIndicator.stopAnimating()
            self?.scollView.isHidden = false
        }
        
        episodeTitleLabel.text = viewModel.episodeTitle
        
        if let episodeImageURL = viewModel.episodeImageURL {
            episodeImageView.setImage(withURL: episodeImageURL.absoluteString, placeholderImage: viewModel.episodePlaceholderImage!)
        } else {
            episodeImageView.image = viewModel.episodePlaceholderImage
        }
        
        seasonEpisodeNumberLabel.text = viewModel.seasonEpisodeNumber
    }
}
