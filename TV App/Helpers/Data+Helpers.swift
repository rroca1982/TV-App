//
//  Data+Helpers.swift
//  TV App
//
//  Created by Rodolfo Roca on 9/25/20.
//  Copyright © 2020 Rodolfo. All rights reserved.
//

import Foundation

extension Data {
    func jsonObject(_ pathComponents: [Any]?=nil) throws -> Any? {
        guard let pathComponents = pathComponents, !pathComponents.isEmpty else {
            return try JSONSerialization.jsonObject(with: self, options: [])
        }
        guard let rootJSONDict = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
            return nil
        }
        var currentJSONObject: Any? = rootJSONDict
        try pathComponents.forEach { pathComponent in
            guard currentJSONObject != nil else {
                return
            }
            if let stringComponent = pathComponent as? String {
                guard let dict = (currentJSONObject as? [String: Any])?[stringComponent] else {
                    throw InternalError.decodingError
                }
                currentJSONObject = dict
            } else if let index = pathComponent as? Int {
                guard let obj = (currentJSONObject as? [Any])?[index] else {
                    throw InternalError.decodingError
                }
                currentJSONObject = obj
            } else {
                fatalError("Unsupported path component type")
            }
        }

        return currentJSONObject
    }
}
