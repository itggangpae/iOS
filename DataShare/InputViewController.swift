//
//  InputViewController.swift
//  DataShare
//
//  Created by Adam on 2021/03/14.
//

import UIKit

class InputViewController: UIViewController {
    @IBOutlet weak var tfName: UITextField!
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBAction func prevViewController(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.name = tfName.text!
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(tfEmail!.text, forKey: "email")
        
        let temp = presentingViewController as! ViewController
        
        temp.dismiss(animated: true){
            () -> Void in
            temp.display()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        tfName.text = appDelegate.name
        
        let userDefaults = UserDefaults.standard
        if let email = userDefaults.string(forKey: "email"){
            tfEmail.text = email
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
