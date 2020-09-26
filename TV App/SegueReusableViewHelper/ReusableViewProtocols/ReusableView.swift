//
//  ReusableView.swift
//  SegueReusableViewHelper
//
//  Created by Rodolfo Roca on 11/13/18.
//  Copyright © 2018 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

public protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    
    public static var reuseIdentifier: String {
        return String.init(describing: self)
    }
}
