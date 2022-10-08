//  AgreementsViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/06.
//  회원 약관동의 화면입니다.

import UIKit

class AgreementsViewController: BaseViewController {
    /// 약관 동의 뷰
    @IBOutlet weak var viewAgreements: UIView?
    /// 다음화면 이동
    @IBOutlet weak var btnNext: UIButton?
    
    /**
     * @약관동의 뷰 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    /**
     * @레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        viewAgreements?.layer.setBorderLayout(radius: 12, width: 1, color: UIColor.black)
        btnNext?.layer.setBorderLayout(radius: 8, width: 0, color: nil)
    }
}

//MARK: Action
extension AgreementsViewController {
    /**
     * @약관 개별 동의
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionAgreeTerms(_ sender: UIButton) {
        print(sender.tag)
    }
    
    /**
     * @약관 전체 동의
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionAgreeTermsAll(_ sender: UIButton) {
        print(sender.tag)
    }
}
