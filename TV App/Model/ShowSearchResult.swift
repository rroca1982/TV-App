//
//  ShowSearchResult.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct ShowSearchResult: Decodable {
    let score: Double
    let show: Show
    
    enum CodingKeys: String, CodingKey {
        case score
        case show
    }
}

extension ShowSearchResult {
    static func fromJson(data: Data) throws -> [ShowSearchResult] {
        guard let obj = try data.jsonObject() else {
            throw InternalError.decodingError
        }
        let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)

        return try JSONDecoder().decode([ShowSearchResult].self, from: data)
    }
}
