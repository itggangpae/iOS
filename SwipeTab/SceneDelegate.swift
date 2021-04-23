//
//  SceneDelegate.swift
//  SwipeTab
//
//  Created by Adam on 2021/03/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let vc1 = FirstVC()
        vc1.view.backgroundColor = UIColor(red: 0.19, green: 0.36, blue: 0.60, alpha: 1.0)
        vc1.title = "First"
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor(red: 0.70, green: 0.23, blue: 0.92, alpha: 1.0)
        vc2.title = "Second"
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor(red: 0.17, green: 0.70, blue: 0.27, alpha: 1.0)
        vc3.title = "Third"
        
        
        let swipeViewController = ViewController(pages: [vc1, vc2, vc3])
        // Button with image example

        let btnFirst = SwipeButtonWithImage(image: UIImage(named: "heart"), selectedImage: UIImage(named: "yellowheart"), size: CGSize(width: 40, height: 40))
        let btnTwo = SwipeButtonWithImage(image: UIImage(named: "message"), selectedImage: UIImage(named: "message"), size: CGSize(width: 40, height: 40))

        let btnThree = SwipeButtonWithImage(image: UIImage(named: "idea"), selectedImage: UIImage(named: "idea"), size: CGSize(width: 40, height: 40))
        swipeViewController.buttonsWithImages = [btnFirst, btnTwo, btnThree]
        swipeViewController.startIndex = 0
        swipeViewController.selectionBarWidth = 80
        swipeViewController.selectionBarHeight = 3
        swipeViewController.selectionBarColor = UIColor(red: 0.23, green: 0.55, blue: 0.92, alpha: 1.0)
        swipeViewController.selectedButtonColor = UIColor(red: 0.23, green: 0.55, blue: 0.92, alpha: 1.0)
        swipeViewController.equalSpaces = false
        
        window?.rootViewController = swipeViewController
        window?.makeKeyAndVisible()
        
     

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

