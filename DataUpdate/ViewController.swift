//
//  ViewController.swift
//  DataUpdate
//
//  Created by Adam on 2021/03/14.
//

import UIKit

import Alamofire
import Nuke

class ViewController: UIViewController {
    var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = UIScreen.main.bounds
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        imageView.center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        self.view.addSubview(imageView)
        
        /*
         //이미지 파일의 내용을 다운로드 받기
         let addr = "http://192.168.0.5:5000/item/img/orange.jpg"
         let imageUrl = URL(string: addr)
         let imageData = try! Data(contentsOf: imageUrl!)
         let image = UIImage(data: imageData)
         imageView.image = image
        */
        
        let fm = FileManager.default
        //도큐먼트 디렉토리 경로를 생성
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        //파일 경로를 생성
        let filePath = docDir + "/orange.jpg"
        let url = "http://192.168.0.5:5000/item/updatetime"
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers:[:])
        request.responseJSON{
            response in
            if response.error != nil{
                NSLog("서버에 접속할 수 없음")
                let image = UIImage(named: "red.jpg")
                self.imageView.image = image
                return
            }
            let updatePath = docDir + "/update.txt"
            var updatetime:String=""
            if fm.fileExists(atPath: updatePath){
                NSLog("업데이트 시간이 존재")
                let databuffer = fm.contents(atPath:updatePath)
                let log = NSString(data: databuffer!, encoding: String.Encoding.utf8.rawValue)
                let localupdatetime = log! as String
                if let jsonObject = response.value as? [String : Any]{
                    updatetime = jsonObject["result"] as! String
                    if updatetime == localupdatetime{
                        NSLog("존재하는 파일로 출력")
                        let dataBuffer = fm.contents(atPath: filePath)
                        //이미지 데이터로 변환
                        let image = UIImage(data: dataBuffer!)
                        //화면에 출력
                        self.imageView.image = image
                        return
                    }
                    
                    else{
                        NSLog("다시 다운로드 받아서 출력")
                        try! fm.removeItem(atPath: updatePath)
                        let request = AF.request("http://192.168.0.5:5000/item/img/orange.jpg", method:.get, parameters:nil)
                        request.response{
                            response in
                            let image = UIImage(data: response.data!)
                            self.imageView!.image = image
                            //다운로드 받은 데이터로 파일을 생성
                            if fm.fileExists(atPath: filePath){
                                try! fm.removeItem(atPath: filePath)
                            }
                            fm.createFile(atPath: filePath, contents: response.data!, attributes: nil)
                        }
                    }
                }
            }
            
            fm.createFile(atPath: updatePath, contents: updatetime.data(using: .utf8), attributes: nil)
            let request = AF.request("http://192.168.0.5:5000/item/img/orange.jpg", method:.get, parameters:nil)
            request.response{
                response in
                let image = UIImage(data: response.data!)
                self.imageView!.image = image
                //다운로드 받은 데이터로 파일을 생성
                if fm.fileExists(atPath: filePath){
                    try! fm.removeItem(atPath: filePath)
                }
                fm.createFile(atPath: filePath, contents: response.data!, attributes: nil)
            }
        }
    }
}

