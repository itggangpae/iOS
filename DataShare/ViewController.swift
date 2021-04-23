//
//  ViewController.swift
//  DataShare
//
//  Created by Adam on 2021/03/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBAction func moveInput(_ sender: Any) {
        if let inputViewController = self.storyboard?.instantiateViewController(withIdentifier: "InputViewController"){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.name = "delegate name"
            
            let userDefaults = UserDefaults.standard
            userDefaults.set("userDefaults email", forKey:"email")
            
            inputViewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.present(inputViewController, animated:true)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        // Do any additional setup after loading the view.
    }

    func display() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            lblName.text = appDelegate.name
            
            let userDefaults = UserDefaults.standard
            if let shareText = userDefaults.string(forKey:"email"){
                lblEmail.text = shareText
            }
    }


}

