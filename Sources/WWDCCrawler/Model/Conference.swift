//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation

struct Conference {
    let title: String
    let videos: [Video]
}

extension Conference {
    struct Video {
        let title: String
        let link: URL
    }
}
