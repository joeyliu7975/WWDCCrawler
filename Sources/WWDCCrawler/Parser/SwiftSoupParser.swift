//
//  File.swift
//  
//
//  Created by JiaSin Liu on 2023/2/24.
//

import Foundation
import SwiftSoup

final class SwiftSoupHTMLParser: HTMLParser {
    func parse(htmlString: String) throws -> Conference {
        do {
            let doc = try SwiftSoup.parse(htmlString)
            
            let title = try doc.title()
            
            let allContents = try doc.select("section").attr("class", "all-content").html()
            
            let contentDoc = try SwiftSoup.parse(allContents)
            
            let videoTitles = try contentDoc.select("h4")
                .attr("class", "video-title")
                .compactMap({ try? $0.html() })
                .reduce(into: [String](), { result, e in
                    if !result.contains(e) {
                        result.append(e)
                    }
                })
            let links = try contentDoc.select("a")
                .compactMap({ try? $0.attr("href")})
                .reduce(into: [String](), { result, e in
                    if e.contains("wwdc"), !result.contains(e) {
                        result.append(e)
                    }
                })
            let videos = zip(videoTitles, links).map {
                let url = URLFactory.makeURL(scheme: .https,
                                             host: .appleDeveloper,
                                             path: $0.1)
                return Conference.Video(title: $0.0,
                                        link: url)
            }
            
            return Conference(title: title, videos: videos)
        } catch {
            throw error
        }
    }
}
