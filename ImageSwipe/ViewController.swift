//
//  ViewController.swift
//  ImageSwipe
//
//  Created by Mac on 2021/02/23.
//

import UIKit

class ViewController: UIViewController {
    var scrollView:UIScrollView?
    var contentView:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrollView = UIScrollView(frame:CGRect(x:60, y:10, width:200, height:400))
        contentView = UIView(frame:CGRect(x:0, y:0, width:1000, height:400))
        var total:Int = 0
        for i  in 0...4
        {
            let imageView = UIImageView(frame:CGRect(x:total, y:0, width:200, height:400))
            total = total + 200
          let image:UIImage! = UIImage(named:"red\(i).jpg")
            imageView.image = image;
               contentView!.addSubview(imageView)
        }
        scrollView!.addSubview(contentView!)
        scrollView!.contentSize = contentView!.frame.size;
        self.view.addSubview(scrollView!);
        scrollView!.isPagingEnabled = true;

    }


}

