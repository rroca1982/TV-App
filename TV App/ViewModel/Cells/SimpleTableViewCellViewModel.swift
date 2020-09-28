//
//  SimpleTableViewCellViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

struct SimpleTableViewCellViewModel {
    
    // MARK: - Properties
    var title: String
    
    // MARK: - Init
    init(model: String) {
        self.title = model
    }
}
