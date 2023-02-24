//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation

enum API {}

extension API {
    enum Scheme: String {
        case https
    }
    
    enum Host: String {
        case appleDeveloper = "developer.apple.com"
    }
}

struct URLFactory {
    static func makeURL(scheme: API.Scheme,
                        host: API.Host,
                        path: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = host.rawValue
        urlComponents.path = path
        return urlComponents.url!
    }
}
