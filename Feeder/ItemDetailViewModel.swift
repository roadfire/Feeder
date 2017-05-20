//
//  ItemDetailViewModel.swift
//  Feeder
//
//  Created by Josh Brown on 5/20/17.
//  Copyright © 2017 Roadfire Software. All rights reserved.
//

import UIKit

class ItemDetailViewModel {
    
    fileprivate let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    func title() -> NSAttributedString {
        return NSAttributedString(string: item.title ?? "")
    }
    
    func content() -> NSAttributedString {
        guard let contentHTML = item.contentHTML else {
            return NSAttributedString(string: "")
        }
        
        let htmlData = NSString(string: contentHTML).data(using: String.Encoding.unicode.rawValue)
        
        let attributedString = try! NSMutableAttributedString(data: htmlData!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        
        return attributedString
    }
    
}
