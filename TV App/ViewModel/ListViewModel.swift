//
//  ListViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

protocol ListViewModel {
    
    associatedtype Model

    var items: [Model] {get}

    func addItems(_ items: [Model])
    func removeAllItems()
    func numberOfRows(_ section: Int) -> Int
    func modelAt(_ index: Int) -> Model
}

extension ListViewModel {
    func numberOfRows(_ section: Int) -> Int {
        return items.count
    }
    
    func modelAt(_ index: Int) -> Model {
        return items[index]
    }
}
