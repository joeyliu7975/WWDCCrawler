//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation

protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    func fetchData(url: URL, completion: @escaping (Result) -> Void)
}
