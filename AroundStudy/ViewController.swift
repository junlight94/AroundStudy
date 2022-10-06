//
//  ViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/27.
//

import UIKit
import SnapKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("스플래쉬 화면")
        
        let _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(appSwitch), userInfo: nil, repeats: false)
        
    }
    
    @objc func appSwitch() {
        /// appDelegate.switchMain()
        let vc = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
