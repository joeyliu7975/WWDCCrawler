//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/25.
//

import Foundation

protocol FileManaging: AnyObject {
    var file: FileConfig { get }
    func createFile()
    func write(content: String)
}

struct FileConfig {
    enum FileType: String {
        case hackMD = ".md"
    }
    
    let name: String
    let type: FileType
}
