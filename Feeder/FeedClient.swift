//
//  FeedClient.swift
//  Feeder
//
//  Created by Josh Brown on 5/20/17.
//  Copyright © 2017 Roadfire Software. All rights reserved.
//

import Foundation

class FeedClient {
    
    fileprivate let parser: FeedParser
    
    init(parser: FeedParser) {
        self.parser = parser
    }
    
    func getFeed(at url: URL, completion: @escaping ([Item]) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Error: no data from GET request: \(url)")
                completion([])
                return
            }
            
            let items = self.parser.items(with: data)
            completion(items)
        }
        
        task.resume()
    }
    
}
