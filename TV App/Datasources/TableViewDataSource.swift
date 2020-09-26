//
//  TableViewDataSource.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where
    CellType: UITableViewCell,
    CellType: NibLoadableView,
    CellType: ReusableView,
    ViewModel: ListViewModel {
    
    var viewModel: ViewModel
    let configureCell: (CellType, ViewModel.Model) -> Void
    
    init(viewModel: ViewModel, tableView: UITableView, configureCell: @escaping (CellType, ViewModel.Model) -> Void) {
        tableView.register(CellType.self)
        tableView.tableFooterView = UIView.init(frame: .zero)
        self.viewModel = viewModel
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellType = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        let model = viewModel.modelAt(indexPath.row)
        self.configureCell(cell, model)
        
        return cell
    }
    
}
