//
//  FrontViewController.swift
//  SideBarMenu
//
//  Created by Adam on 2021/03/17.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 메인 컨트롤러의 참조 정보를 가져온다.
                if let revealVC = self.revealViewController() {
                    // 버튼이 클릭될 때 메인 컨트롤러에 정의된 revealToggle(_:)을 호출하도록 정의한다.
                    self.sideBarButton.target = revealVC
                    self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
                    
                    // 제스처를 뷰에 추가한다.
                    self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
                }

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
