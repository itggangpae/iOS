//
//  ItemEditVC.swift
//  NodeiOS
//
//  Created by Adam on 2021/03/14.
//

import UIKit
import Alamofire

class ItemEditVC: UIViewController {
    var item : Item! = nil
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemname: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var tfDescription: UITextField!
    
    @IBAction func edit(_ sender: Any) {
        let image = imageView.image
        let imageData = image!.jpegData(compressionQuality: 0.50)
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("\(self.item.itemid!)".utf8), withName: "itemid")
            multipartFormData.append(Data(self.itemname.text!.utf8), withName: "itemname")
            multipartFormData.append(Data(self.price.text!.utf8), withName: "price")
            multipartFormData.append(Data(self.tfDescription.text!.utf8), withName: "description")
            multipartFormData.append(Data(self.item.pictureurl!.utf8), withName: "oldpictureurl")
            multipartFormData.append(imageData!, withName: "pictureurl",fileName: "rainbow.jpg", mimeType: "image/jpg")
            
        }, to: "http://172.30.30.93:5000/item/modify").responseJSON { response in
            
            if let jsonObject = response.value as? [String : Any]{
                let result = jsonObject["result"] as! Bool
                var msg : String?
                if result == true{
                    msg = "수정 성공"
                }else{
                    msg = "수정 실패"
                }
                let alert = UIAlertController(title: "데이터 수정",
                                              message: msg!,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .cancel){(_ action) -> Void in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                self.present(alert, animated: false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemname.text = item.itemname
        price.text = "\(item.price!)"
        tfDescription.text = item.description
    }
}
