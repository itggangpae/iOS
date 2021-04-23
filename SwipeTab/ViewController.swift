//
//  ViewController.swift
//  SwipeTab
//
//  Created by Adam on 2021/03/17.
//

import UIKit

class ViewController: SwipeViewController {
    @objc func push(sender _: UIBarButtonItem) {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.purple
            vc.title = "Cool"
            self.navigationController!.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
            super.viewDidLoad()
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(push))
            barButtonItem.tintColor = .black
            self.navigationItem.leftBarButtonItem = barButtonItem
    }


}

