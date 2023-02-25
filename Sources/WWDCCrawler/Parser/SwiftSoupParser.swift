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
            let contentDoc = try filterContentDocument(doc)
            
            let title = try doc.title()
            let videoTitles = try filerVideoTitles(doc: contentDoc)
            let links = try filterLinks(doc: contentDoc)
            
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
    
    private func filterContentDocument(_ doc: Document) throws -> Document {
        do {
            let allContents = try doc.select("section").attr("class", "all-content").html()
            let contentDoc = try SwiftSoup.parse(allContents)
            return contentDoc
        } catch {
            throw error
        }
    }
    
    private func filterLinks(doc: Document) throws -> [String] {
        do {
            let links = try doc.select("a")
                .compactMap({ try? $0.attr("href")})
                .reduce(into: [String](), { result, e in
                    if e.contains("wwdc"), !result.contains(e) {
                        result.append(e)
                    }
                })
            return links
        } catch {
            throw error
        }
    }
    
    private func filerVideoTitles(doc: Document) throws -> [String] {
        do {
            let titles = try doc.select("h4")
                .attr("class", "video-title")
                .compactMap({ try? $0.html() })
                .reduce(into: [String](), { result, e in
                    if !result.contains(e) {
                        result.append(e)
                    }
                })
            
            return titles
        } catch {
            throw error
        }
    }
}
