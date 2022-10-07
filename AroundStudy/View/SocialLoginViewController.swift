//
//  SocialLoginViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/07.
//

import UIKit

class SocialLoginViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var buttonKakao: UIButton!
    @IBOutlet weak var buttonNaver: UIButton!
    @IBOutlet weak var buttonApple: UIButton!
    @IBOutlet weak var buttonGoogle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: - Layout & Functions
extension SocialLoginViewController {
    /**
     초기 레이아웃 설정
     > coder : **sanghyeon**
     */
    func setupView() {
        /// 스택뷰 내부 뷰들 코너 라운딩
        for view in stackView.subviews {
            view.layer.cornerRadius = 8
        }
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        switch sender {
        case buttonKakao:
            print("카카오 눌림")
        case buttonNaver:
            print("네이버 눌림")
        case buttonApple:
            print("애플 눌림")
        case buttonGoogle:
            print("구글 눌림")
        default: break
        }
    }
}
