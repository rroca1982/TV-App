//
//  CastCredit.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/27/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct CastCredit: Decodable {
    let embedded: Embedded
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
    
    struct Embedded: Decodable {
        let show: Show
        
        enum CodingKeys: String, CodingKey {
            case show = "show"
        }
    }
}

extension CastCredit {
    static func fromJson(data: Data) throws -> [CastCredit] {
        guard let obj = try data.jsonObject() else {
            throw InternalError.decodingError
        }
        let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)

        return try JSONDecoder().decode([CastCredit].self, from: data)
    }
}
