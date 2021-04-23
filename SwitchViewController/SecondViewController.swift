//
//  SecondViewController.swift
//  SwitchViewController
//
//  Created by Adam on 2021/04/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblSecond: UILabel!
    
    var data : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        lblSecond.text = data

        // Do any additional setup after loading the view.
    }
    
    @IBAction func movePrev(_ sender: Any) {
        let mainViewController =  self.presentingViewController as! ViewController
        mainViewController.subData = "다시 돌아옴"

        self.presentingViewController?.dismiss(animated: true)

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.presentingViewController?.dismiss(animated: true)
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
