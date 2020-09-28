//
//  SeasonListViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

class SeasonListViewModel: ListViewModel {
    typealias Model = Season
    
    // MARK: - Properties
    private let service: Gettable?
    
    private(set) var items = [Season]()
    
    // MARK: - Init
    init<S: Gettable>(service: S) {
        self.service = service
    }
    
    // MARK: - ListViewModel Conformance
    func addItems(_ items: [Model]) {
        self.items.append(contentsOf: items)
    }
    
    func removeAllItems() {
        items.removeAll()
    }
    
    // MARK: - Fetch data
    func fetchSeasons(showID: Int, completion: @escaping (Result<Bool>) -> Void) {
        guard let service = service as? ShowsService else {
            completion(.Failure(SwiftyRestKitError.serviceError))
            return
        }
        
        service.fetchSeasons(showID: showID) { [weak self] (result) in
            switch result {
            case .Success(let seasons):
                self?.addItems(seasons)
                completion(.Success(true))
            case .Failure(let error):
                completion(.Failure(error))
            }
        }
    }
}
