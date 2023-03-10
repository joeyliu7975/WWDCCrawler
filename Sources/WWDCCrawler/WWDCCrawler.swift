import Foundation

@main
public struct WWDCCrawler {

    public static func main() {
        var year = 2022
        
        guard CommandLine.arguments.count < 3 else {
            print("Too many parameter, it only accept one parameter")
            return
        }
        
        if CommandLine.arguments.count > 1 {
            if let inputYear = Int(CommandLine.arguments[1]) {
                year = inputYear
            } else  {
                print("Passing parameter \(CommandLine.arguments[1]) is not valid year, please try again!")
            }
        }
        // TODO: Replace `2013` by obtainning the earliest year of WWDC, retrieve data from https://developer.apple.com/videos/all-videos/.
        guard year > 2013, year < getCurrentYear() else {
            print("The selecting year of WWDC videos are not available from https://developer.apple.com/videos/all-videos/")
            return
        }
        
        let sema = DispatchSemaphore(value: 0)
        
        let url = URLFactory.makeURL(scheme: .https,
                                     host: .appleDeveloper,
                                     path: "/videos/wwdc\(year)/")
        
        let client = URLSessionClient()
        let parser = SwiftSoupHTMLParser()
        let crawler = WebCrawler(url: url, client: client, parser: parser)
        
        let fileManager = HackMDManager(fileName: "WWDC_\(year)")
        
        crawler.crawlingURL { [sema, fileManager] (result) in
            switch result {
            case let .success(conference):
                fileManager.createFile()
                fileManager.write(content: conference.makeHackMDContent())
            case let .failure(error):
                print(error)
            }
            sema.signal()
        }
        print("Start Retrieving Data...")
        sema.wait()
    }
    
    static func getCurrentYear() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let currYear = calendar.component(.year, from: date)
        return currYear
    }
}

private extension Conference {
    func makeHackMDContent() -> String {
        var content = "# \(title)\n"
        content += videos.enumerated().map({ "### \($0 + 1). [\($1.title)](\($1.link))" }).joined(separator: "\n")
        return content
    }
}
