//
//  InternalError.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo Roca. All rights reserved.
//
import Foundation

enum InternalError: Error {
    case decodingError
    case noDataError
    case urlBuildingError
    case validationError
    case unknownError
}
