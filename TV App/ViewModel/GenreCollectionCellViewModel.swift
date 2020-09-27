//
//  GenreCollectionCellViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

struct GenreCollectionCellViewModel {
    var name: String
    var labelBackgroundColor: UIColor
    var textColor: UIColor

    init(model: String) {
        name = model
        labelBackgroundColor = .randomColor
        textColor = .white
    }
}
