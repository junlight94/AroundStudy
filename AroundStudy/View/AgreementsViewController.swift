//  AgreementsViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/06.
//  회원 약관동의 화면입니다.

import UIKit

class AgreementsViewController: BaseViewController {
    /// 약관 동의 뷰
    @IBOutlet weak var viewAgreements: UIView?
    /// 약관 개별동의 아이템 리스트
    @IBOutlet var agreementsItem: [UIButton]?
    /// 약관 전체동의
    @IBOutlet weak var agreementsAll: UIButton?
    /// 다음화면 이동
    @IBOutlet weak var btnNext: UIButton?
    
    /// 약관동의 버튼 태그 열거
    //FIXME: 약관 이름 나오면, 케이스 이름 변경할 것.
    enum AgreementsTag: Int, CaseIterable {
        case one = 0
        case two
        case three
        case four
        case five
        
        var code: Int {
            return self.rawValue
        }
    }
    
    ///약관동의 선택여부 확인 체크리스트
    var agreements: [(Int,Bool)] = [
        (AgreementsTag.one.code, false)
        , (AgreementsTag.two.code, false)
        , (AgreementsTag.three.code, false)
        , (AgreementsTag.four.code, false)
        , (AgreementsTag.five.code, false)
    ] {
        didSet {
            for index in agreements {
                if index.1 == false {
                    agreementsAll?.isSelected = false
                    print("fail")
                    return
                }
            }
            print("success")
            agreementsAll?.isSelected = true
        }
    }
    
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
        sender.isSelected = !sender.isSelected
        agreements[sender.tag].1 = sender.isSelected
    }
    
    /**
     * @약관 전체 동의
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionAgreeTermsAll(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let agreementsAllStatus = sender.isSelected
        for index in 0 ..< agreements.count {
            agreementsItem?[index].isSelected = agreementsAllStatus
            agreements[index].1 = agreementsAllStatus
        }
    }
}
