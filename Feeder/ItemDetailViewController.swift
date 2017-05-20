//
//  ItemDetailViewController.swift
//  Feeder
//
//  Created by Josh Brown on 5/19/17.
//  Copyright © 2017 Roadfire Software. All rights reserved.
//


import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var contentLabel: UILabel!
    
    var viewModel: ItemDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.attributedText = viewModel?.title()
        titleLabel.preferredMaxLayoutWidth = titleLabel.bounds.size.width
        
        let content = NSMutableAttributedString(attributedString: (viewModel?.content())!)
        content.addAttribute(NSFontAttributeName, value: UIFont(name: "Gill Sans", size: 16) as Any, range: NSMakeRange(0, content.length))

        contentLabel.attributedText = content
        contentLabel.preferredMaxLayoutWidth = contentLabel.bounds.size.width
    }
}
