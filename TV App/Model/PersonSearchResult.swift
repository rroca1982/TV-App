//
//  PersonSearchResult.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct PersonSearchResult: Decodable {
    let score: Double
    let person: Person
    
    enum CodingKeys: String, CodingKey {
        case score
        case person
    }
}

extension PersonSearchResult {
    static func fromJson(data: Data) throws -> [PersonSearchResult] {
        guard let obj = try data.jsonObject() else {
            throw InternalError.decodingError
        }
        let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)

        return try JSONDecoder().decode([PersonSearchResult].self, from: data)
    }
}
