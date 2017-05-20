//
//  ItemListViewController.swift
//  Feeder
//
//  Created by Josh Brown on 5/19/17.
//  Copyright © 2017 Roadfire Software. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum Segues: String {
        case showDetail = "showDetail"
    }
    
    @IBOutlet var tableView: UITableView!
    var viewModel: ItemListViewModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewModel = ItemListViewModel(client: FeedClient())
        
        viewModel?.didLoad = viewModelDidLoad
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
        if let cell = cell as? ItemListCell {
            cell.titleLabel?.text = viewModel?.title(forRowAt: indexPath)
            cell.dateLabel?.text = viewModel?.datePublished(forRowAt: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func viewModelDidLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.showDetail.rawValue,
            let detailVC = segue.destination as? ItemDetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            
            detailVC.viewModel = viewModel?.detailViewModel(forRowAt: indexPath)
        }
    }
}

