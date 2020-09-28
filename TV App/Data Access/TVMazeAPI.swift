//
//  TVMazeAPI.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

//MARK: -
enum TVMazeAPI {
    //MARK: TV Shows
    case allShows(page: Int)
    case showDetails(showID: Int)
    case showSeasons(showID: Int)
    case seasonEpisodes(seasonID: Int)
    case episodeDetails(episodeID: Int)

    //MARK: People
    case castCredits(personID: Int)
    
    //MARK: Search
    case searchShows(searchTerm: String)
    case searchPeople(searchTerm: String)
}

//MARK: -
extension TVMazeAPI: EndPointType {
    var apiClientKey: String? {
        return nil
    }
    
    var apiClientSecret: String? {
        return nil
    }
    
    var baseURLString : String {
        return "https://api.tvmaze.com/"
    }
    
    var baseURL: URL {
        guard let url = URL(string: baseURLString) else {
            fatalError("baseURL could not be configured.")}
        return url
    }
    
    //MARK: -
    var path: String {
        switch self {
        
        //MARK: TV Shows
        case .allShows:
            return "shows"
        case .showDetails(let showID):
            return "shows/\(showID)"
        case .showSeasons(let showID):
            return "shows/\(showID)/seasons"
        case .seasonEpisodes(let seasonID):
            return "seasons/\(seasonID)/episodes"
        case .episodeDetails(let episodeID):
            return "episodes/\(episodeID)"
            
        //MARK: People
        case .castCredits(let personID):
            return "people/\(personID)/castcredits"

        //MARK: Search
        case .searchShows:
            return "search/shows"
        case .searchPeople:
            return "search/people"
        }
    }
    
    //MARK: -
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    //MARK: -
    var task: HTTPTask {
        switch self {
        //MARK: TV Shows
        case .allShows(let page):
            let urlParameters: Parameters = ["page" : page]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
        case .showDetails:
            return .requestWith(bodyParameters: nil, urlParameters: nil)
        case .showSeasons:
            return .requestWith(bodyParameters: nil, urlParameters: nil)
        case .seasonEpisodes:
            return .requestWith(bodyParameters: nil, urlParameters: nil)
        case .episodeDetails:
            return .requestWith(bodyParameters: nil, urlParameters: nil)
            
        //MARK: People
        case .castCredits:
            let urlParameters: Parameters = ["embed" : "show"]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
        
        //MARK: Search
        case .searchShows(let searchTerm):
            let urlParameters: Parameters = ["q" : searchTerm]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
        case .searchPeople(let searchTerm):
            let urlParameters: Parameters = ["q" : searchTerm]
            return .requestWith(bodyParameters: nil, urlParameters: urlParameters)
        }
    }
    
    //MARK: -
    var headers: HTTPHeader? {
        switch self {
            
        default:
            return nil
        }
    }
}
