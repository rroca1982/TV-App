//
//  TVAppSegmentedControl.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

class TVAppSegmentedControl: UISegmentedControl {
    override func draw(_ rect: CGRect) {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.primaryColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .medium)], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .medium)], for: .selected)
    }
}
