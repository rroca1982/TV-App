//
//  Image.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/26/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

struct Image: Decodable {
    let medium: String
    let original: String
    
    enum CodingKeys: String, CodingKey {
        case medium
        case original
    }
}
