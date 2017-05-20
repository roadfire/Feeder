//
//  ItemListViewModel.swift
//  Feeder
//
//  Created by Josh Brown on 5/19/17.
//  Copyright © 2017 Roadfire Software. All rights reserved.
//

import Foundation

class ItemListViewModel {
    
    fileprivate let client: FeedClient
    fileprivate let formatter: DateFormatter
    
    fileprivate var items = [Item]()
    
    var didLoad: (() -> Void)?
    
    init(client: FeedClient) {
        self.client = client
        
        formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
//        formatter.timeStyle = .none
        
        let url = URL(string: "https://daringfireball.net/feeds/json")!
        client.getFeed(at: url) { items in
            self.items = items
            self.didLoad?()
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(inSection: Int) -> Int {
        return items.count
    }
    
    func title(forRowAt indexPath: IndexPath) -> String {
        return items[indexPath.row].title ?? ""
    }
    
    func datePublished(forRowAt indexPath: IndexPath) -> String {
        return formatter.string(from: items[indexPath.row].datePublished!)
    }
    
    func detailViewModel(forRowAt indexPath: IndexPath) -> ItemDetailViewModel {
        return ItemDetailViewModel(item: items[indexPath.row])
    }
    
}
