//
//  RegisterCompleteViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/07.
//

import UIKit

class RegisterCompleteViewController: BaseViewController {

    @IBOutlet weak var bottomButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.bottomButtonBottomConstraint.constant = self.bottomMargin
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func didTapOKButton(_ sender: Any) {
        print("확인 버튼 눌림")
    }
}
