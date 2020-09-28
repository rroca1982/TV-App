//
//  Episode.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct Episode: Decodable {
    let id: Int
    let number: Int?
    let name: String?
    let season: Int?
    let image: Image?
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case id
        case number
        case name
        case season
        case image
        case summary
    }
}

extension Episode {
    static func fromJson(data: Data) throws -> [Episode] {
        guard let obj = try data.jsonObject() else {
            throw InternalError.decodingError
        }
        let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)

        return try JSONDecoder().decode([Episode].self, from: data)
    }
}
