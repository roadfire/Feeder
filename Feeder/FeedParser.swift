//
//  FeedParser.swift
//  Feeder
//
//  Created by Josh Brown on 5/20/17.
//  Copyright © 2017 Roadfire Software. All rights reserved.
//

import Foundation

class FeedParser {
    
    func items(with data: Data) -> [Item] {
        var items = [Item]()
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("error parsing JSON")
                return items
            }
            
            guard let itemsJSON = json["items"] as? [[String: Any]] else {
                print("error getting items")
                return items
            }
            
            for itemJSON in itemsJSON {
                guard let id = itemJSON["id"] as? String else {
                    print("error on id")
                    continue
                }
                
                let urlString = itemJSON["url"] as? String
                let title = itemJSON["title"] as? String
                let contentHTML = itemJSON["content_html"] as? String
                let datePublishedString = itemJSON["date_published"] as? String
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let datePublished = formatter.date(from: datePublishedString!)
                
                let item = Item(id: id, url: urlString, title: title, contentHTML: contentHTML, datePublished: datePublished)
                items.append(item)
            }
        } catch {
            print("Error parsing feed JSON: \(error)")
        }
        
        return items
    }
    
}
