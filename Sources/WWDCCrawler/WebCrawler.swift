//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation
import SwiftSoup

final class WebCrawler {
    
    typealias Result = Swift.Result<Conference, Error>
    
    private let url: URL
    private let client: HTTPClient
    private let parser: HTMLParser
    
    enum Error: Swift.Error {
        case invalidData
        case htmlParseError
        case connectivityError
    }
    
    init(url: URL, client: HTTPClient, parser: HTMLParser) {
        self.url = url
        self.client = client
        self.parser = parser
    }
    
    func crawlingURL(completion: @escaping (Result) -> Void) {
        client.fetchData(url: url) { result in
            switch result {
            case let .success((data, response)):
                let result = self.map(data: data, response: response)
                completion(result)
            case .failure(_):
                completion(.failure(Error.connectivityError))
            }
        }
    }
}

private extension WebCrawler {
    func map(data: Data, response: HTTPURLResponse) -> Result {
        if 200...299 ~= response.statusCode {
            let string = String(decoding: data, as: UTF8.self)
            guard let doc = try? parser.parse(htmlString: string) else { return .failure(Error.htmlParseError) }
            return .success(doc)
        } else {
            return .failure(Error.invalidData)
        }
    }
}
