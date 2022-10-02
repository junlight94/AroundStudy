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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let testVC = TestViewController(nibName: "TestViewController", bundle: nil)
        testVC.modalTransitionStyle = .crossDissolve
        testVC.modalPresentationStyle = .fullScreen
        self.present(testVC, animated: false)
    }
}
