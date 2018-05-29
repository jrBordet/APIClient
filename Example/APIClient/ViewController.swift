//
//  ViewController.swift
//  APIClient
//
//  Created by jrBordet on 03/06/2018.
//  Copyright (c) 2018 jrBordet. All rights reserved.
//

import UIKit
import APIClient

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let client = APIClient("http://mywebservice.com")

    var dataSource: [CommonModel]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        _ = client.perform(request: GetCommon()) { result in
            switch result {
            case .success(let data):
                self.dataSource = data
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = dataSource else { return UITableViewCell.init(style: .default, reuseIdentifier: nil) }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCellIdentifier", for: indexPath) as UITableViewCell
        
        let cm = dataSource[indexPath.row]
        
        cell.textLabel?.text = cm.title ?? ""
        cell.detailTextLabel?.text = cm.text ?? ""
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

