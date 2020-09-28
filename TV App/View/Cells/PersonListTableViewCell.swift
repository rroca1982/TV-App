//
//  PersonListTableViewCell.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import UIKit

class PersonListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var holdingView: UIView!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius = CGFloat(3.0)
        photoImageView.layer.cornerRadius = cornerRadius
        holdingView.addDefaultPosterShadow()
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func prepareForReuse() {
        photoImageView.image = UIImage.init(named: "posterPlaceholderLarge")
    }
    
    // MARK - Setup
    func update(with viewModel: PersonListTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        if let pictureUrl = viewModel.photoURL {
            photoImageView.setImage(withURL: pictureUrl.absoluteString, placeholderImage: viewModel.photoPlaceholder!)
        } else {
            photoImageView.image = viewModel.photoPlaceholder
        }
    }
}

extension PersonListTableViewCell : NibLoadableView, ReusableView { }
