//
//  SearchService.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct SearchService {

    func searchShows(title: String, completion: @escaping (Result<[ShowSearchResult]>) -> Void) {
        manager.dispatcher.request(.searchShows(searchTerm: title)) { (data, response, error) in
            if let error = error {
                let networkError = ErrorHandler.sharedInstance.convertNSURLError(error)
                completion(Result.Failure(networkError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(Result.Failure(SwiftyRestKitError.decodingFailed))
                return
            }
            
            let result = self.manager.handleNetworkResponse(response)
            
            switch result {
            case .Success:
                guard let responseData = data else {
                    completion(Result.Failure(InternalError.decodingError))
                    return
                }
                 
                do {
                    let shows = try ShowSearchResult.fromJson(data: responseData)
                    completion(Result.Success(shows))
                } catch {
                    print(error)
                    completion(Result.Failure(InternalError.decodingError))
                }
            case .Failure(let error):
                print(error.localizedDescription)
                completion(Result.Failure(error))
            }
        }
    }
    
    func searchPeople(name: String, completion: @escaping (Result<[PersonSearchResult]>) -> Void) {
        manager.dispatcher.request(.searchPeople(searchTerm: name)) { (data, response, error) in
            if let error = error {
                let networkError = ErrorHandler.sharedInstance.convertNSURLError(error)
                completion(Result.Failure(networkError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(Result.Failure(SwiftyRestKitError.decodingFailed))
                return
            }
            
            let result = self.manager.handleNetworkResponse(response)
            
            switch result {
            case .Success:
                guard let responseData = data else {
                    completion(Result.Failure(InternalError.decodingError))
                    return
                }
                 
                do {
                    let people = try PersonSearchResult.fromJson(data: responseData)
                    completion(Result.Success(people))
                } catch {
                    print(error)
                    completion(Result.Failure(InternalError.decodingError))
                }
            case .Failure(let error):
                print(error.localizedDescription)
                completion(Result.Failure(error))
            }
        }
    }
}

extension SearchService: Service {
    typealias EndPoint = TVMazeAPI
}

extension SearchService: Gettable { }
