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
    var data = [String]()
    var fileURL: URL!
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        
        createRightButton()
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        fileURL = baseURL.appendingPathComponent("notes.txt")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loaNotes()
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
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        tableView.insertRows(at: [indexPath], with: .automatic)
        self.performSegue(withIdentifier: "DetailViewController", sender: nil)
    }
    
    func saveNote() {
        //UserDefaults.standard.set(data, forKey: "notes")
        
        let noteArray = NSArray(array: data)
        do {
            try noteArray.write(to: fileURL)
        } catch  {
            print("error while saving data to file")
        }
    }
    
    func loaNotes() {
        if let loadedNotes = NSArray(contentsOf: fileURL) as? [String] {
            data = loadedNotes
            tableView.reloadData()
        }
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
        saveNote()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailVC = segue.destination as? DetailViewController
        selectedRow = tableView.indexPathForSelectedRow!.row
        detailVC?.setText(t: data[selectedRow])
    }
}
