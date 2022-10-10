//
//  AppDelegate.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootNavigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    

    // MARK: - general function
    func switchMain() {
        
        // 메인
        let vc = RootTabViewController(nibName: "RootTabViewController", bundle: nil)
        rootNavigationController = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        // 테스트용
//        let vc = InputNickNameViewController(nibName: "InputNickNameViewController", bundle: nil)
//        rootNavigationController = UINavigationController(rootViewController: vc)
//        self.window?.rootViewController = rootNavigationController
//        window?.makeKeyAndVisible()
    }


}

// MARK: - extension UIViewController
extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

// MARK: - extension NavigationController
extension AppDelegate: UINavigationControllerDelegate {
    
}
