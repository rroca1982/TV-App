//
//  NibLoadableView.swift
//  SegueReusableViewHelper
//
//  Created by Rodolfo Roca on 11/13/18.
//  Copyright © 2018 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

public protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    
    public static var NibName: String {
        return String(describing: self)
    }
}
