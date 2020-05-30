//
//  ViewController.swift
//  PlainNotes
//
//  Created by ganesh padole on 30/05/20.
//  Copyright © 2020 ganesh padole. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var data = ["Item 1","Item 2","Item 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTakingCell")
        cell?.textLabel?.text = data[indexPath.row]
        
        return cell!
    }
    
    
}
