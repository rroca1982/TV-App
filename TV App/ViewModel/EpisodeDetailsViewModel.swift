//
//  EpisodeDetailsViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

struct EpisodeDetailsViewModel {
    var episodeTitle: String
    var episodeImageURL: URL?
    let episodePlaceholderImage = UIImage.init(named: "backdropPlaceholderLarge")
    var seasonEpisodeNumber: String
    var summary: NSAttributedString?
    
    init(model: Episode) {
        if let name = model.name {
            self.episodeTitle = name
        } else {
            self.episodeTitle = "Title not available".localized()
        }
        
        if let season = model.season {
            seasonEpisodeNumber = "Season".localized() + " "  + String(season)
        } else {
            seasonEpisodeNumber = "Season unknown".localized()
        }
        seasonEpisodeNumber += " - "
        if let episode = model.number {
            seasonEpisodeNumber += "Episode".localized() + " "  + String(episode)
        } else {
            seasonEpisodeNumber += "Episode unknown".localized()
        }
        
        if let posterPath = model.image?.medium {
            let fixedPath = posterPath.replacingOccurrences(of: "http", with: "https", options: .literal, range: nil)
            self.episodeImageURL = URL.init(string: fixedPath)
        }
        
        if let summary = model.summary, !summary.isEmpty {
            let attributedSummary = NSMutableAttributedString(attributedString: summary.fromHTMLToAttributedString())
            attributedSummary.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.darkGray], range: NSRange(location: 0, length: attributedSummary.string.count))
            self.summary = attributedSummary
        } else {
            self.summary = NSAttributedString(string: "This episode does not have a summary yet".localized())
        }
    }
}
