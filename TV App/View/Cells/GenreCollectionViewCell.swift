//
//  GenreCollectionViewCell.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var holdingView: UIView!
    @IBOutlet weak private var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius: CGFloat = self.frame.size.height / 2.0
        holdingView.layer.cornerRadius = cornerRadius
    }
    
    func update(with viewModel: GenreCollectionCellViewModel) {
        holdingView.backgroundColor = viewModel.labelBackgroundColor
        genreLabel.textColor = viewModel.textColor
        genreLabel.text = viewModel.name
    }
}

extension GenreCollectionViewCell: ReusableView, NibLoadableView { }
