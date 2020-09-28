//
//  PersonDetailsViewModel.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailsViewModel: ListViewModel {
    typealias Model = Show
    
    // MARK: - Properties
    var name: String
    var photoURL: URL?
    let photoPlaceholder = UIImage.init(named: "posterPlaceholderLarge")
    
    private let service: Gettable?
    
    private(set) var items = [Show]()
    
    // MARK: - Init
    init<S: Gettable>(service: S, model: Person) {
        self.service = service
        name = model.name
        
        if let posterPath = model.image?.medium {
            let fixedPath = posterPath.replacingOccurrences(of: "http", with: "https", options: .literal, range: nil)
            self.photoURL = URL.init(string: fixedPath)
        }
    }
    
    // MARK: - ListViewModel Conformance
    func addItems(_ items: [Model]) {
        self.items.append(contentsOf: items)
    }
    
    func removeAllItems() {
        items.removeAll()
    }
    
    // MARK: - Fetch data
    func fetchCastCredits(personID: Int, completion: @escaping (Result<Bool>) -> Void) {
        guard let service = service as? PeopleService else {
            completion(.Failure(SwiftyRestKitError.serviceError))
            return
        }
        
        service.fetchCredits(personID: personID) { [weak self] (result) in
            switch result {
            case .Success(let shows):
                self?.addItems(shows)
                completion(.Success(true))
            case .Failure(let error):
                completion(.Failure(error))
            }
        }
    }
    
}
