//
//  ViewController.swift
//  ScrollViewTest
//
//  Created by Mac on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {

    var imageView:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let image:UIImage! = UIImage(named:"large.jpg")
//        imageView = UIImageView(image:image);
//        imageView?.isUserInteractionEnabled = true
//        self.view.addSubview(imageView!)
        
        let image:UIImage! = UIImage(named:"large.jpg")
          imageView = UIImageView(image:image);
          imageView?.isUserInteractionEnabled = true
          let imageSize = imageView!.frame.size;
          let scrollView = UIScrollView(frame:UIScreen.main.bounds);
          scrollView.isScrollEnabled=true
          scrollView.contentSize = imageSize
          scrollView.addSubview(imageView!)
          self.view.addSubview(scrollView)
        
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.5
        //스크롤 뷰의 delegate 메소드는 self 에 있는 것을 사용합니다.
        scrollView.delegate = self


    }
}

extension ViewController:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
