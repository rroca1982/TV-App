//
//  PersonListTableViewCellViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

struct PersonListTableViewCellViewModel {
    
    // MARK: - Properties
    var title: String
    var photoURL: URL?
    let photoPlaceholder = UIImage.init(named: "posterPlaceholderLarge")
    
    // MARK: - Init
    init(model: Person) {
        title = model.name
        
        if let posterPath = model.image?.medium {
            let fixedPath = posterPath.replacingOccurrences(of: "http", with: "https", options: .literal, range: nil)
            self.photoURL = URL.init(string: fixedPath)
        }
    }
}
