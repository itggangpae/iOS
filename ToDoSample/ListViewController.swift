//
//  ListViewController.swift
//  ToDoSample
//
//  Created by Adam on 2021/04/23.
//

import UIKit

class ListViewController: UITableViewController {
    var items = ["쇼핑", "친구들과 약속", "Scala 학습"]
    var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Do"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func add(_ sender: Any) {
        let addViewController = self.storyboard!.instantiateViewController(withIdentifier:"AddViewController") as! AddViewController
        addViewController.listVC = self
        self.navigationController?.pushViewController(addViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.tableView.reloadData()
   }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
   }
       
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return items.count
   }
       
       
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           
           cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
           cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
           
           return cell
   }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
               items.remove(at: (indexPath as NSIndexPath).row)
               itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
           }
   }

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
            return "삭제"
    }
     
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
           let itemToMove = items[(fromIndexPath as NSIndexPath).row]
           let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
           items.remove(at: (fromIndexPath as NSIndexPath).row)
           itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
           items.insert(itemToMove, at: (to as NSIndexPath).row)
           itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row)
   }

}
