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
//        appDelegate.switchMain()
    }
    
    @IBAction func actionMoveOpen(_ sender: Any) {
        let vc = OpenStudyStep3ViewController(nibName: "OpenStudyStep3ViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
