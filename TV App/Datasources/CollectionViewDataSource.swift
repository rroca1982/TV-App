//
//  CollectionViewDataSource.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource<CellType, ViewModel>: NSObject, UICollectionViewDataSource where
    CellType: UICollectionViewCell,
    CellType: NibLoadableView,
    CellType: ReusableView,
    ViewModel: ListViewModel {
    
    // MARK: - Properties
    var viewModel: ViewModel
    let configureCell: (CellType, ViewModel.Model) -> Void
    
    // MARK: - Init
    init(viewModel: ViewModel, collectionView: UICollectionView, configureCell: @escaping (CellType, ViewModel.Model) -> Void) {
        collectionView.register(CellType.self)
        self.viewModel = viewModel
        self.configureCell = configureCell
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CellType = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        let model = viewModel.modelAt(indexPath.item)
        self.configureCell(cell, model)
        
        return cell
    }
}
