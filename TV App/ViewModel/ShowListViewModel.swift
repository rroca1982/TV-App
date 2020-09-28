//
//  ShowListViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

class ShowListViewModel: ListViewModel {
    typealias Model = Show
    
    // MARK: - Properties

    private let service: Gettable?
    
    private(set) var items = [Show]()
    private(set) var hasReachedLastPage: Bool = false
    
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
    func fetchShows(page: Int, completion: @escaping (Result<Bool>) -> Void) {
        guard let service = service as? ShowsService else {
            completion(.Failure(SwiftyRestKitError.serviceError))
            return
        }
        
        service.fetchAllShows(page: page) { [weak self] (result) in
            switch result {
            case .Success(let shows):
                self?.addItems(shows)
                completion(.Success(true))
            case .Failure(let error):
                if let restError = error as? SwiftyRestKitError, restError == .resourceNotFound {
                    self?.hasReachedLastPage = true
                }
                completion(.Failure(error))
            }
        }
    }
    
    func searchShows(title: String, completion: @escaping (Result<Bool>) -> Void) {
        guard let service = service as? SearchService else {
            completion(.Failure(SwiftyRestKitError.serviceError))
            return
        }
        
        service.searchShows(title: title) { [weak self] (result) in
            switch result {
            case .Success(let searchResults):
                let shows: [Show] = searchResults.map { (searchResult) -> Show in
                    return searchResult.show
                }
                self?.addItems(shows)
                completion(.Success(true))
            case .Failure(let error):
                completion(.Failure(error))
            }
        }
    }
}
