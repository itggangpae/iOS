//
//  MovieDetailViewController.swift
//  AlamofireMovie
//
//  Created by Adam on 2021/03/04.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
   
    var link : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let address = link {
             let webURL = URL(string: address)
             let urlRequest = URLRequest(url: webURL!)
             webView.load(urlRequest)
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
