//
//  LocalizableProtocol.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
    var localized: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}
enum DataLoaderStrings: String, Localizable {
    case loadingData = "loading_data"
    case dataLoaded = "data_loaded"
    
    var tableName: String {
        return "DataLoader"
    }
}
