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
                    let shows = try Show.fromJson(data: responseData)
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
    
    func fetchSeasons(showID: Int, completion: @escaping (Result<[Season]>) -> Void) {
        manager.dispatcher.request(.showSeasons(showID: showID)) { (data, response, error) in
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
                    let seasons = try Season.fromJson(data: responseData)
                    completion(Result.Success(seasons))
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
    
    func fetchEpisodes(seasonID: Int, completion: @escaping (Result<[Episode]>) -> Void) {
        manager.dispatcher.request(.seasonEpisodes(seasonID: seasonID)) { (data, response, error) in
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
                    let episodes = try Episode.fromJson(data: responseData)
                    completion(Result.Success(episodes))
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

extension ShowsService: Service {
    typealias EndPoint = TVMazeAPI
}

extension ShowsService: Gettable { }
