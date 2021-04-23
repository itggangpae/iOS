//
//  ViewController.swift
//  ReadBundle
//
//  Created by Adam on 2021/03/14.
//

import UIKit
import WebKit

import Alamofire
class ViewController: UIViewController {
    var webView : WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameterS: Parameters = ["itemname": "과자", "description":"맛있다", "price":"1500"]
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameterS {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                }
                let image = UIImage(named: "Rainbow.jpg")
                multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "pictureurl" , fileName: "file.jpeg", mimeType: "image/jpeg")
            },to: "http://192.168.0.5:5000/item/insert", method: .post , headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                NSLog(String(data:response.data!, encoding: .utf8)!)
            }
        
    }
}

