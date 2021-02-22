//
//  ViewController.swift
//  iOS
//
//  Created by Mac on 2021/02/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Hello SDK"

    }

    @IBAction func onClick1(_ sender: Any) {
        self.view.backgroundColor = UIColor.red
    }
    
    @IBAction func onClick2(_ sender: Any) {
        self.view.backgroundColor = UIColor.blue
    }
}

