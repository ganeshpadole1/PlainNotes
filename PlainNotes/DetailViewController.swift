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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = text
    }
    
    func setText(t: String) {
        text = t
        if isViewLoaded {
            textView.text = t
        }
    }
   
}
