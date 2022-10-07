//
//  OnboardingViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/06.
//

import UIKit

class OnboardingViewController: BaseViewController {
    @IBOutlet weak var bottomButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomButton: Button_General!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}
//MARK: - Layout & Functions
extension OnboardingViewController {
    /**
     초기 레이아웃 설정
     - 뷰의 요소의 속성을 변경합니다.
     > coder : **sanghyeon**
     */
    func setupView() {
        DispatchQueue.main.async {
            self.bottomButtonBottomConstraint.constant = self.bottomMargin
            self.view.layoutIfNeeded()
        }
        /// 네비게이션 스와이프 제스쳐로 스플래시뷰로 이동 막기
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        /// 페이지 컨트롤 iOS14에서 생긴 옵션들 처리
        pageControl.backgroundStyle = .minimal
        pageControl.allowsContinuousInteraction = false
        /// 스크롤뷰 델리게이트 채택
        scrollView.delegate = self
    }
    
    /**
     온보딩 페이지 이동
     - 보여지는 온보딩의 뷰를 이동합니다.
     > Parameter :
     - page : 이동시킬 페이지
     > coder :  **sanghyeon**
     */
    func movePage(page: Int) {
        pageControl.currentPage = page
        /// 페이지에 따라 하단 버튼 타이틀 변경
        bottomButton.setTitle(page == 2 ? "스터디 시작하기" : "다음", for: .normal)
    }
    
    /**
     하단 버튼 클릭시 동작 분기처리
     > coder : **sanghyeon**
     */
    @IBAction func didTapBottomButton(_ sender: Any) {
        switch bottomButton.titleLabel?.text {
        case "다음":
            UIView.animate(withDuration: 0.3, delay: 0) {
                /// 스크롤뷰 컨텐츠 위치 변경
                self.scrollView.contentOffset.x = self.scrollView.frame.width * CGFloat(self.pageControl.currentPage + 1)
            }
        default: moveNextVC()
        }
    }
    
    /**
     상단 클로즈 버튼 클릭시
     > coder : **sanghyeon**
     */
    @IBAction func didTapCloseButton(_ sender: Any) {
        moveNextVC()
    }
    
    /**
     앱 접근권한 안내 페이지로 이동
     > coder : sanghyeon
     */
    func moveNextVC() {
        let vc = PermissionViewController(nibName: "PermissionViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - ScrollView
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let size = scrollView.contentOffset.x / scrollView.frame.size.width
        movePage(page: Int(round(size)))
    }
}
