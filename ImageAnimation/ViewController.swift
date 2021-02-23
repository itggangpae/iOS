//
//  ViewController.swift
//  ImageAnimation
//
//  Created by Mac on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblPage: UILabel!
    
    //이미지 뷰의 애니메이션에 적용될 UIImage 인스턴스의 배열
    var imgArray = [UIImage]()
    //현재 출력 중인 이미지의 인덱스
    var i:Int?
    //이미지 뷰의 애니메이션 속도
    var    speed:Float?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1:UIImage! = UIImage(named:"red0.jpg")
        let image2:UIImage! = UIImage(named:"red1.jpg")
        let image3:UIImage! = UIImage(named:"red2.jpg")
        let image4:UIImage! = UIImage(named:"red3.jpg")
        let image5:UIImage! = UIImage(named:"red4.jpg")
        imgArray.append(image1)
        imgArray.append(image2)
        imgArray.append(image3)
        imgArray.append(image4)
        imgArray.append(image5)
        
        imgView.animationImages = imgArray;
        i = 0;
        speed = 0.5;
        imgView.image = imgArray[0]
        lblPage.text = "\(i!+1)/\(imgArray.count)"
        
    }
    
    @IBAction func prev(_ sender: Any) {
        i=i!-1
        if i! < 0{
            i = imgArray.count-1;
        }
        imgView.image = imgArray[i!];
        lblPage.text = "\(i!+1)/\(imgArray.count)"
    }
    
    @IBAction func play(_ sender: Any) {
        if imgView.isAnimating == false
        {
            speed = speed! * 5.0
            imgView.animationDuration = TimeInterval(Int(speed!) * imgArray.count);
            imgView.startAnimating()
            (sender as! UIButton).setTitle("중지", for:.normal)
        }
        else
        {
            imgView.stopAnimating()
            (sender as! UIButton).setTitle("시작", for:.normal)
        }

    }
    
    @IBAction func next(_ sender: Any) {
        i=i!+1
        if i! > imgArray.count-1{
            i = 0;
        }
        imgView.image = imgArray[i!];
        lblPage.text = "\(i!+1)/\(imgArray.count)"
    }
    
    
    @IBAction func chandSpeed(_ sender: Any) {
        speed  = slider.value
        if imgView.isAnimating{
            imgView.stopAnimating()
            speed = slider.value * 5
            imgView.animationDuration = TimeInterval(Int(speed!) * imgArray.count);
            imgView.startAnimating()
        }
    }
}

