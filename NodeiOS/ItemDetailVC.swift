//
//  DetailViewController.swift
//  NodeiOS
//
//  Created by Adam on 2021/03/10.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblUpdateDate: UILabel!
    @IBOutlet weak var tvTextView: UITextView!
    
    var item : Item! = nil
    
    @objc func edit(_ sender:UIBarButtonItem){
        let itemEditVC = self.storyboard?.instantiateViewController(identifier: "ItemEditVC") as! ItemEditVC
        itemEditVC.item = self.item
        self.navigationController?.pushViewController(itemEditVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "상세보기"
        
        if let data = item{
            imageView.image = data.image
            lblItemName.text = data.itemname
            lblPrice.text = "\(data.price!)원"
            lblUpdateDate.text = data.updatedate
            tvTextView.text = data.description
        }
        
        let editBtn = UIBarButtonItem(title: "데이터 수정", style: .done, target: self, action: #selector(edit(_:)))

        self.navigationItem.rightBarButtonItem = editBtn
    }
    
    
}
