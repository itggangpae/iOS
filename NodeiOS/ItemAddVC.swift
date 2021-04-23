//
//  AddViewController.swift
//  NodeiOS
//
//  Created by Adam on 2021/03/09.
//

import UIKit
import Alamofire
class ItemAddVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemname: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var tfDescription: UITextField!
    
    @IBAction func add(_ sender: Any) {
        let image = imageView.image
        let imageData = image!.jpegData(compressionQuality: 0.50)
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(self.itemname.text!.utf8), withName: "itemname")
            multipartFormData.append(Data(self.price.text!.utf8), withName: "price")
            multipartFormData.append(Data(self.tfDescription.text!.utf8), withName: "description")
            multipartFormData.append(imageData!, withName: "pictureurl",fileName: "rainbow.jpg", mimeType: "image/jpg")
            
        }, to: "http://172.30.30.93:5000/item/insert").responseJSON { response in
            
            if let jsonObject = response.value as? [String : Any]{
                let result = jsonObject["result"] as! Bool
                var msg : String?
                if result == true{
                    msg = "삽입 성공"
                }else{
                    msg = "삽입 실패"
                }
                let alert = UIAlertController(title: "데이터 삽입",
                                              message: msg!,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "확인", style: .cancel){(_ action) -> Void in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alert, animated: false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
