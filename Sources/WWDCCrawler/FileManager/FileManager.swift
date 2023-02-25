//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation

final class HackMDManager: FileManaging {
    let file: FileConfig
    private let fileManager: FileManager
    private lazy var path: String = {
        fileManager.currentDirectoryPath + "/\(file.name)\(file.type.rawValue)"
    }()
    
    init(fileName: String,
         _ fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.file = FileConfig(name: fileName,
                                 type: .hackMD)
    }
    
    func createFile() {
        if (fileManager.createFile(atPath: path, contents: nil, attributes: nil)) {
            print("\(file.name) created successfully.\n")
        } else {
            print("\(file.name) can not be created.\n")
        }
    }
    
    func write(content: String) {
        guard fileManager.fileExists(atPath: path) else {
            print("\(path) doesn't exist!!!")
            return
        }
        
        do {
            try content.write(toFile: path, atomically: true, encoding: .utf8)
            print("The content has been written into \(path) successfully")
        } catch {
            print("\(#function): #\(content)")
        }
    }
}

