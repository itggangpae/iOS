//
//  ToDoInputViewController.swift
//  ToDo
//
//  Created by Adam on 2021/03/14.
//

import UIKit
import CoreData
class ToDoInputViewController: UIViewController {
    var mode = "삽입"
    var object: NSManagedObject!
    
    var t = ""
    var c = ""
    var r : Date = Date()
    
    
    @IBOutlet weak var titleView: UITextField!
    
    @IBOutlet weak var contentsView: UITextView!
    
    @IBOutlet weak var runtimeView: UIDatePicker!
    
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        let navVC = self.presentingViewController as! UINavigationController
        let toDoListViewController = navVC.topViewController as! ToDoViewController
        let title = titleView.text
        let contents = contentsView.text
        let runtime = runtimeView.date
        
        var result = false
        if mode == "삽입"{
            result = toDoListViewController.save(title: title!, contents: contents!, runtime: runtime)
        }else{
            result = toDoListViewController.edit(object:object, title: title!, contents: contents!, runtime: runtime)
        }
        
        /*
         let result = toDoListViewController.save(title: title!, contents: contents!, runtime: runtime)
         */
        
        toDoListViewController.dismiss(animated: true){()->(Void)in
            if result == true {toDoListViewController.tableView.reloadData()}
            else {
                let alert = UIAlertController(title: "삽입실패", message: "데이터를 확인해보세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == "수정"{
            self.titleView.text = t
            self.contentsView.text = c
            self.runtimeView.date = r
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
