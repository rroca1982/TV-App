//
//  EpisodeDetailsViewController.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {

    @IBOutlet private weak var episodeImageView: UIImageView!
    @IBOutlet private weak var episodeTitleLabel: UILabel!
    @IBOutlet private weak var seasonEpisodeNumberLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    
    var episode: Episode!
    
    private var viewModel: EpisodeDetailsViewModel?
    
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
        
        episodeTitleLabel.text = viewModel.episodeTitle
        
        if let episodeImageURL = viewModel.episodeImageURL {
            episodeImageView.setImage(withURL: episodeImageURL.absoluteString, placeholderImage: viewModel.episodePlaceholderImage!)
        } else {
            episodeImageView.image = viewModel.episodePlaceholderImage
        }
        
        seasonEpisodeNumberLabel.text = viewModel.seasonEpisodeNumber
        summaryLabel.attributedText = viewModel.summary
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
