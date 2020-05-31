//
//  DetailViewController.swift
//  PlainNotes
//
//  Created by ganesh padole on 30/05/20.
//  Copyright © 2020 ganesh padole. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var text = ""
    var masterView: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        masterView.newRowText = textView.text
        textView.resignFirstResponder()
    }
    
    func setText(t: String) {
        text = t
        if isViewLoaded {
            textView.text = t
        }
    }
   
}
