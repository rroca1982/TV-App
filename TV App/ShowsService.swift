//
//  ShowsService.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct ShowsService {

    func fetchAllShows(page: Int, completion: @escaping (Result<[Show]>) -> Void) {
        manager.dispatcher.request(.allShows(page: page)) { (data, response, error) in
            let result = self.processResult(data, response, error)
            completion(result)
        }
    }
    
    fileprivate func processResult(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<[Show]> {
        if let error = error {
            let networkError = ErrorHandler.sharedInstance.convertNSURLError(error)
            return Result.Failure(networkError)
        }
        
        guard let response = response as? HTTPURLResponse else {
            return Result.Failure(SwiftyRestKitError.decodingFailed)
        }
        
        let result = self.manager.handleNetworkResponse(response)
        
        switch result {
        case .Success:
            guard let responseData = data else {
                return Result.Failure(InternalError.decodingError)
            }
             
            do {
                let shows = try Show.fromJson(data: responseData)
                return Result.Success(shows)
            } catch {
                print(error)
                return Result.Failure(InternalError.decodingError)
            }
        case .Failure(let error):
            print(error.localizedDescription)
            if let _ = error as? NetworkManager<TVMazeAPI>.NetworkResponse {
                return Result.Failure(SwiftyRestKitError.resourceNotFound)
            }
            return Result.Failure(SwiftyRestKitError.lostConnection)
        }
    }
}

extension ShowsService: Service {
    typealias EndPoint = TVMazeAPI
}

extension ShowsService: Gettable { }
