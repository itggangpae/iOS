//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Adam on 2021/03/03.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var imgView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let request = AF.request("https://httpbin.org/get", method:.get, parameters:nil)
        //                request.response{
        //                    response in
        //                    let msg = String.init(data: response.data!, encoding: String.Encoding.utf8)
        //                    print(msg!)
        //        }
        
        //        let request = AF.request("https://www.daum.net", method:.get, parameters:nil)
        //               request.responseString(completionHandler: {response -> Void in
        //                       print(response.value!)
        //                   }
        //       )
        
        
        //        self.imgView = UIImageView(frame: CGRect(x:0,y:0,width:320,height:200))
        //        self.view.addSubview(self.imgView!)
        //        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        let request = AF.request("http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG", method:.get, parameters:nil)
        //        request.response{
        //            response in
        //
        //            print(response.data!)
        //            let image = UIImage(data: response.data!)
        //            //화면에 출력
        //            sleep(10)
        //            self.imgView!.image = image
        //            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //        }
        
//        let addr = "https://dapi.kakao.com/v3/search/book?target=title&query="
//        let query = "자바".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//        let url = "\(addr)\(query!)"
//        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:["Authorization": "KakaoAK 06fab290c9f4eb6f130c09796d57bc30"])
//
//        request.responseJSON{
//            response in
//            //print(response.result.value!)
//            if let jsonObject = response.value as? [String : Any]{
//                let documents = jsonObject["documents"] as! NSArray
//                for index in 0...(documents.count-1){
//                    let item = documents[index] as! NSDictionary
//                    print("\(item["authors"]!) - \(item["title"]!)")
//                }
//            }
//        }
        
        
//        let image = UIImage(named: "google.jpg")!
//        let imageData = image.jpegData(compressionQuality: 0.50)
//        print(image, imageData!)
//
//        AF.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(Data("구글".utf8), withName: "itemname")
//            multipartFormData.append(Data("10000".utf8), withName: "price")
//            multipartFormData.append(Data("ABC".utf8), withName: "description")
//            multipartFormData.append(Data("2012-03-03".utf8), withName: "updatedate")
//            multipartFormData.append(imageData!, withName: "pictureurl",fileName: "google.jpg", mimeType: "image/jpg")
//
//        }, to: "http://cyberadam.cafe24.com/item/insert").responseJSON { response in
//
//            if let jsonObject = response.value as? [String : Any]{
//                let result = jsonObject["result"] as! Int
//                print(result)
//            }
//        }
        
        let url = "http://cyberadam.cafe24.com/item/delete"
        let parameters: [String: String] = ["itemid": "8"]

        let request = AF.request(url, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default)
        request.responseJSON{
            response in
            if let jsonObject = response.value as? [String : Any]{
                print(jsonObject)
                let result = jsonObject["result"] as! Int
                print(result)
            }
        }
        
    }
}

