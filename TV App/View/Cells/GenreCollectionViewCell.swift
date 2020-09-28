//
//  GenreCollectionViewCell.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var holdingView: UIView!
    @IBOutlet private weak var genreLabel: UILabel!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius: CGFloat = self.frame.size.height / 2.0
        holdingView.layer.cornerRadius = cornerRadius
    }
    
    // MARK: - Setup
    func update(with viewModel: GenreCollectionCellViewModel) {
        holdingView.backgroundColor = viewModel.labelBackgroundColor
        genreLabel.textColor = viewModel.textColor
        genreLabel.text = viewModel.name
    }
}

extension GenreCollectionViewCell: ReusableView, NibLoadableView { }
