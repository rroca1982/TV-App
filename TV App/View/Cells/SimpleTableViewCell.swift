//
//  SimpleTableViewCell.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    
    func update(with viewModel: SimpleTableViewCellViewModel) {
        titleLabel.text = viewModel.title
    }
}

extension SimpleTableViewCell: ReusableView, NibLoadableView { }
