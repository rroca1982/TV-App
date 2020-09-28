//
//  UIView+Helpers.swift
//  
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: - Shadows
    func addDefaultDropShadow() {
        let defaultOffset: CGSize = CGSize(width: 0, height: 0)
        let defaultRadius: CGFloat = 2.0
        let defaultOpacity: Float = 0.5

        self.addDropShadow(color: .darkGray, offSet: defaultOffset, radius: defaultRadius, opacity: defaultOpacity)
    }
    
    func addDefaultPosterShadow() {
        let defaultOffset: CGSize = CGSize(width: 0, height: 5)
        let defaultRadius: CGFloat = 6.0
        let defaultOpacity: Float = 0.7
        
        self.addDropShadow(color: .darkGray, offSet: defaultOffset, radius: defaultRadius, opacity: defaultOpacity)
    }
    
    func addDropShadow(color: UIColor, offSet: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
}
