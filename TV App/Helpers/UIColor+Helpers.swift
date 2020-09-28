//
//  UIColor+Helpers.swift
//
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var primaryColor: UIColor {
        return UIColor.init(named: "primaryColor")!
    }
    
    class var darkGrayText: UIColor {
        return UIColor.init(named: "darkGrayText")!
    }
    
    class var lightGrayText: UIColor {
        return UIColor.init(named: "lightGrayText")!
    }
    
    class var randomColor: UIColor {
        let salmonColor = UIColor.init(r: 255, g: 95, b: 88)
        let orangeColor = UIColor.init(r: 250, g: 153, b: 23)
        let yellowColor = UIColor.init(r: 243, g: 202, b: 62)
        let greenColor = UIColor.init(r: 42, g: 201, b: 64)
        let lightBlueColor = UIColor.init(r: 51, g: 153, b: 255)
        let cyanColor = UIColor.init(r: 51, g: 225, b: 255)
        let pinkColor = UIColor.init(r: 255, g: 51, b: 102)
        let lightGrayColor = UIColor.lightGray
        let purpleColor = UIColor.purple
        let primaryRedColor = UIColor.primaryColor
        
        let colors = [salmonColor, orangeColor, yellowColor, greenColor, lightBlueColor, cyanColor, pinkColor, lightGrayColor, purpleColor, primaryRedColor]
        
        if let pickedColor = colors.randomElement() {
            return pickedColor
        }
        return UIColor.brown
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
