//
//  URLParameterEncoder.swift
//  SwiftyRestKit
//
//  Created by Rodolfo Roca on 12/10/18.
//  Copyright © 2018 Rodolfo Roca. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else {
            throw SwiftyRestKitError.missingURL
        }

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            if let correctedURLString = urlComponents.url?.absoluteString.replacingOccurrences(of: "%2520", with: "%20") {
                urlRequest.url = URL(string: correctedURLString)
            } else {
                urlRequest.url = urlComponents.url
            }
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf8", forHTTPHeaderField: "Content-Type")
            }
        }
    }
}
