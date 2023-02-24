//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation

final class HackMDManager {
    private let fileName: String
    private let fileManager: FileManager
    private lazy var path: String = {
        fileManager.currentDirectoryPath + "/\(fileName).md"
    }()
    
    init(fileName: String,
         _ fileManager: FileManager = .default) {
        self.fileManager = fileManager
        self.fileName = fileName
    }
    
    func createFile() {
        if (fileManager.createFile(atPath: path, contents: nil, attributes: nil)) {
            print("\(fileName) created successfully.\n")
        } else {
            print("\(fileName) can not be created.\n")
        }
    }
    
    func write(content: String) {
        guard fileManager.fileExists(atPath: path) else {
            print("\(path) doesn't exist!!!")
            return
        }
        
        do {
            try content.write(toFile: path, atomically: true, encoding: .utf8)
            print("written successfully")
        } catch {
            print("\(#function): #\(content)")
        }
    }
}

