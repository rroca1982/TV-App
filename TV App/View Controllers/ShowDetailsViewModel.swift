//
//  ShowDetailsViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

import UIKit

struct ShowDetailsViewModel {
    var tvShowTitle: String
    var posterImageURL: URL?
    let posterPlaceholderImage = UIImage.init(named: "posterPlaceholderLarge")
    var runtime: String
    var time: String
    var days: String
    var summary: NSAttributedString?
    
    init(model: Show) {
        self.tvShowTitle = model.name
        
        if let runtime = model.runtime {
            self.runtime = String(runtime) + " " + "min".localized()
        } else {
            self.runtime = "Not available".localized()
        }
        
        if let posterPath = model.image?.medium {
            let fixedPath = posterPath.replacingOccurrences(of: "http", with: "https", options: .literal, range: nil)
            self.posterImageURL = URL.init(string: fixedPath)
        }
        
        if let summary = model.summary {
            let attributedSummary = NSMutableAttributedString(attributedString: summary.fromHTMLToAttributedString())
            attributedSummary.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.darkGray], range: NSRange(location: 0, length: attributedSummary.string.count))
            self.summary = attributedSummary
        } else {
            self.summary = NSAttributedString(string: "This TV Show does not have a summary yet".localized())
        }
        
        self.time = model.schedule.time
        
        self.days = ""
        for (i, day) in model.schedule.days.enumerated() {
            self.days += "\(day)"
            if i < model.schedule.days.count - 1  {
                self.days += "\n"
            }
        }
    }
}
