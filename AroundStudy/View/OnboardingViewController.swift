//
//  OnboardingViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/06.
//

import UIKit

class OnboardingViewController: BaseViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bottomButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension OnboardingViewController {
    /**
     초기 레이아웃 설정
     - 뷰의 요소의 속성을 변경합니다.
     > coder : **sanghyeon**
     */
    func setupView() {
        pageControl.backgroundStyle = .minimal
        pageControl.allowsContinuousInteraction = false

        DispatchQueue.main.async {
            self.bottomButtonBottomConstraint.constant = self.bottomMargin
            self.view.layoutIfNeeded()
        }
    }
}
