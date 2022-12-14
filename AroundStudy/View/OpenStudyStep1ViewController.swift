//  OpenStudyStep1ViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/18.
//  스터디 개설 1단게 뷰 컨트롤러

import UIKit

class OpenStudyStep1ViewController: BaseViewController {
    /// 카테고리 버튼 리스트
    @IBOutlet var aryCategoryBtn: [UIButton]?
    /// 카레고리 이름 리스트
    @IBOutlet var aryCategoryLbl: [UILabel]?
    /// 스터디 개설 다음단계 이동 버튼
    @IBOutlet weak var btnNext: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initLayout()
    }
    
    /**
     * @레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        aryCategoryBtn?.enumerated().forEach({
            $1.layer.setBorderLayout(radius: 8)
            $1.tag = $0
        })
        btnNext?.layer.setBorderLayout(radius: 8)
        btnNext?.isUserInteractionEnabled = false
    }
    
    /**
     * @네비게이션 초기화
     * @creator : coder3306
     */
    private func initNavigationBar() {
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "back"), for: .normal)
        back.addTarget(self, action: #selector(popToView(_:)), for: .touchUpInside)
        let naviItems = NavigationBarItems(title: "스터디 개설", leftBarButton: [back])
        setNavigationBar(naviItems: naviItems)
    }
}

//MARK: - Action
extension OpenStudyStep1ViewController {
    /**
     * @스터디 주제 선택 후처리
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionSelectCategory(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        aryCategoryBtn?.forEach({
            $0.isSelected = false
            $0.layer.setBorderLayout(radius: 8)
            $0.backgroundColor = UIColor(named: "248")
        })
        aryCategoryLbl?.forEach({
            $0.textColor = UIColor(named: "68")
        })
        sender.isSelected = true
        sender.layer.setBorderLayout(radius: 8, width: 1.2, color: UIColor(named: "Main"))
        sender.backgroundColor = UIColor(red: 249, green: 252, blue: 247, alpha: 1)
        aryCategoryLbl?[sender.tag].textColor = UIColor(named: "Main")
        btnNext?.isUserInteractionEnabled = true
        btnNext?.backgroundColor = UIColor(named: "Main")
        btnNext?.setTitleColor(UIColor.white, for: .normal)
    }
    
    /**
     * @스터디 개설 다음단계 이동
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionNextStep(_ sender: UIButton) {
        let step2 = OpenStudyStep2ViewController(nibName: "OpenStudyStep2ViewController", bundle: nil)
        self.navigationController?.pushViewController(step2, animated: true)
    }
}
