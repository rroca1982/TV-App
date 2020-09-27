//
//  Season.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct Season: Decodable {
    let id: Int
    let number: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
    }
}

extension Season {
    static func fromJson(data: Data) throws -> [Season] {
        guard let obj = try data.jsonObject() else {
            throw InternalError.decodingError
        }
        let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)

        return try JSONDecoder().decode([Season].self, from: data)
    }
}
