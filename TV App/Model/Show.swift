//
//  Show.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct Show: Decodable {
    let id: Int
    let name: String
    let image: Image?
    var summary: String?
    let genres: [String]
    let runtime: Int?
    let schedule: Schedule
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case summary
        case genres
        case runtime
        case schedule
    }
    
    struct Schedule: Decodable {
        let time: String
        let days: [String]
        
        enum CodingKeys: String, CodingKey {
            case time
            case days
        }
    }
}

extension Show {
    static func fromJson(data: Data) throws -> [Show] {
        guard let obj = try data.jsonObject() else {
            throw InternalError.decodingError
        }
        let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)

        return try JSONDecoder().decode([Show].self, from: data)
    }
}
