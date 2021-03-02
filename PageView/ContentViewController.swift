//
//  ContentViewController.swift
//  PageView
//
//  Created by Adam on 2021/03/02.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var subData : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let imageName = subData{
                imgView.image = UIImage(named: imageName)
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
