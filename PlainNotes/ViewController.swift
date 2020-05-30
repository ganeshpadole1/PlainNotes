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
       
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        
        createRightButton()
        self.navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func createRightButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addNote() {
        
        if tableView.isEditing {
            return
        }
        
        let note = "Item \(data.count + 1)"
        data.insert(note, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
