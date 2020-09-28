//
//  ShowListTableViewCellViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

struct ShowListTableViewCellViewModel {
    
    // MARK: - Properties
    var showTitle: String
    var posterImageURL: URL?
    let posterPlaceholderImage = UIImage.init(named: "posterPlaceholderLarge")
    var genre: String?
    
    // MARK: - Init
    init(model: Show) {
        self.showTitle = model.name
        
        if let posterPath = model.image?.medium {
            let fixedPath = posterPath.replacingOccurrences(of: "http", with: "https", options: .literal, range: nil)
            self.posterImageURL = URL.init(string: fixedPath)
        }
        
        if let mainGenre = model.genres.first {
            genre = mainGenre
        }
    }
}
