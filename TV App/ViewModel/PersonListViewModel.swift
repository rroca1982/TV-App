//
//  PersonListViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

class PersonListViewModel: ListViewModel {
    typealias Model = Person
    
    // MARK: - Properties

    private let service: Gettable?
    
    private(set) var items = [Person]()
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
    func searchPerson(name: String, completion: @escaping (Result<Bool>) -> Void) {
        guard let service = service as? SearchService else {
            completion(.Failure(SwiftyRestKitError.serviceError))
            return
        }
        
        service.searchPeople(name: name) { [weak self] (result) in
            switch result {
            case .Success(let searchResults):
                let people: [Person] = searchResults.map { (searchResult) -> Person in
                    return searchResult.person
                }
                self?.addItems(people)
                completion(.Success(true))
            case .Failure(let error):
                completion(.Failure(error))
            }
        }
    }
}
