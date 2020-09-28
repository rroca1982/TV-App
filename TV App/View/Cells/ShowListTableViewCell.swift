//
//  ShowListTableViewCell.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class ShowListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var posterHoldingView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var showTitleLabel: UILabel!
    
    @IBOutlet private weak var genreHoldingView: UIView!
    @IBOutlet private weak var genreLabel: UILabel!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        let posterCornerRadius = CGFloat(6.0)
        posterHoldingView.addDefaultPosterShadow()
        posterImageView.layer.cornerRadius = posterCornerRadius
        
        let genreCornerRadius = CGFloat(genreHoldingView.frame.height / 2)
        genreHoldingView.layer.cornerRadius = genreCornerRadius
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func prepareForReuse() {
        posterImageView.image = UIImage.init(named: "posterPlaceholderLarge")
    }

    // MARK: - Setup
    func update(with viewModel: ShowListTableViewCellViewModel) {
        if let posterImageURL = viewModel.posterImageURL {
            posterImageView.setImage(withURL: posterImageURL.absoluteString, placeholderImage: viewModel.posterPlaceholderImage!)
        } else {
            posterImageView.image = viewModel.posterPlaceholderImage
        }
        
        showTitleLabel.text = viewModel.showTitle
        
        if let genre = viewModel.genre {
            genreLabel.text = genre
            genreHoldingView.backgroundColor = UIColor.randomColor
        } else {
            genreLabel.text = "Not available".localized()
            genreHoldingView.backgroundColor = .darkGray
        }
    }
}

extension ShowListTableViewCell: ReusableView, NibLoadableView { }
