//
//  PeopleService.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct PeopleService {

    func fetchCredits(personID: Int, completion: @escaping (Result<[Show]>) -> Void) {
        manager.dispatcher.request(.castCredits(personID: personID)) { (data, response, error) in
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
                    let credits = try CastCredit.fromJson(data: responseData)
                    let shows: [Show] = credits.map { (cast) -> Show in
                        return cast.embedded.show
                    }
                    completion(Result.Success(shows))
                } catch {
                    print(error)
                    completion(Result.Failure(InternalError.decodingError))
                }
            case .Failure(let error):
                print(error.localizedDescription)
                if let _ = error as? NetworkManager<TVMazeAPI>.NetworkResponse {
                    completion(Result.Failure(SwiftyRestKitError.resourceNotFound))
                }
                completion(Result.Failure(error))
            }
        }
    }
}

extension PeopleService: Service {
    typealias EndPoint = TVMazeAPI
}

extension PeopleService: Gettable { }
