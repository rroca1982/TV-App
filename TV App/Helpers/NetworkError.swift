//
//  NetworkError.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case lostConnection
    case invalidAPIKey
    case notFound
    case unknownError
}
