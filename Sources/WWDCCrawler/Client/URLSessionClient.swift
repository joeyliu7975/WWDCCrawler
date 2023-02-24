//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation

final class URLSessionClient: HTTPClient {
    
    typealias Result = HTTPClient.Result
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum Error: Swift.Error {
        case unexpectedError
    }
    
    func fetchData(url: URL, completion: @escaping (Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(Error.unexpectedError))
            }
        }.resume()
    }
}
