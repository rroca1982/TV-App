//
//  Date+Helpers.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToReleaseDateString() -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: self)
    }
}
