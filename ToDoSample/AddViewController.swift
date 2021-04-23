//
//  AddViewController.swift
//  ToDoFirst
//
//  Created by Munseok Park on 2020/08/18.
//  Copyright © 2020 Munseok Park. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var listVC : ListViewController!

    @IBOutlet weak var tfItem: UITextField!
    
    @IBAction func add(_ sender: Any) {
        listVC.items.append(tfItem.text!)
        listVC.itemsImageFile.append("clock.png")
        tfItem.text=""
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
