//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation

protocol HTMLParser {
    func parse(htmlString: String) throws -> Conference
}
