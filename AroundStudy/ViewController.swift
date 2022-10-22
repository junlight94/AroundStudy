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
        //appDelegate.switchMain()
    }
    override func loadView() {
        super.loadView()
        let vc = PhotoPickerViewController(nibName: "PhotoPickerViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
