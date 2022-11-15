//  OpenStudyStep3ViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/15.
//  스터디 개설 3단계 뷰 컨트롤러

import UIKit

class OpenStudyStep3ViewController: BaseViewController {
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 장소 선택 버튼
    @IBOutlet weak var btnPlace: UIButton?
    /// 시간 선택 뷰
    @IBOutlet weak var viewTimes: UIView?
    /// 스터디 개설하기
    @IBOutlet weak var btnFinish: UIButton?
    /// 스터디 진행방식 선택 버튼 리스트
    @IBOutlet var aryProcess: [UIButton]?
    /// 스터디 날짜 선택 버튼 리스트
    @IBOutlet var aryWeekday: [UIButton]?
    /// 스터디 선택된 인원 라벨
    @IBOutlet weak var lblPersonnel: UILabel?
    
    /// 선택된 인원
    private var selectedPersonnel = 2
    /// 스터디 진행방식 온라인/오프라인 구분 
    private var isOffline = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initLayout()
    }
    
    /**
     * @네비게이션 설정 초기화
     * @creator : coder3306
     */
    private func initNavigationBar() {
        let back = UIButton(type: .custom)
        back.addTarget(self, action: #selector(popToView(_:)), for: .touchUpInside)
        back.setImage(UIImage(named: "back"), for: .normal)
        setNavigationBar("스터디 개설", leftBarButton: [back])
    }
    
    /**
     * @레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        aryProcess?.forEach({
            let color = $0.isSelected ? UIColor(named: "Main") : UIColor(named: "236")
            $0.layer.setBorderLayout(radius: 8, width: 1, color: color)
        })
        btnPlace?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        aryWeekday?.forEach({
            $0.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        })
        viewTimes?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnFinish?.layer.setBorderLayout(radius: 8)
        lblPersonnel?.text = "\(selectedPersonnel)"
    }
}

//MARK: Action
extension OpenStudyStep3ViewController {
    /**
     * @진행방식 선택
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionSelectProcess(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        
        aryProcess?.forEach({
            $0.isSelected = ($0.tag == sender.tag) ? true : false
            let color = $0.isSelected ? UIColor(named: "Main") : UIColor(named: "236")
            let font = $0.isSelected ? UIFont.setCustomFont(.medium, size: 15)
                                     : UIFont.setCustomFont(.regular, size: 15)
            let fontColor = $0.isSelected ? UIColor(named: "40") : UIColor(named: "134")
            $0.layer.setBorderLayout(radius: 8, width: 1, color: color)
            $0.titleLabel?.font = font
            $0.setTitleColor(fontColor, for: .normal)
        })
        isOffline = (sender.tag == 0 && sender.isSelected) ? true : false
        let placeTitle = isOffline ? "오프라인 장소 검색" : "온라인 장소 검색"
        btnPlace?.setTitle(placeTitle, for: .normal)
    }
    
    /**
     * @장소 선택
     * @param sender : UIButton
     * @creator : coder3306
     */
    @IBAction private func actionSelectPlace(_ sender: UIButton) {

    }
    
    @IBAction private func actionSelectWeekday(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let color = sender.isSelected ? UIColor(named: "Main") : UIColor(named: "236")
        let font = sender.isSelected ? UIFont.setCustomFont(.medium, size: 15)
                                 : UIFont.setCustomFont(.regular, size: 15)
        let fontColor = sender.isSelected ? UIColor(named: "40") : UIColor(named: "134")
        sender.layer.setBorderLayout(radius: 8, width: 1, color: color)
        sender.titleLabel?.font = font
        sender.setTitleColor(fontColor, for: .normal)
    }
    
    /**
     * @시간 선택
     * @param sender : UIButton
     * @creator : coder3306
     */
    @IBAction private func actionSelectTime(_ sender: UIButton) {

    }
    
    /**
     * @정원 선택
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionSelectPersonnel(_ sender: UIButton) {
        if (selectedPersonnel <= 2 && sender.tag == -1)
            || (selectedPersonnel >= 100 && sender.tag == 1) {
            return
        }
        selectedPersonnel += sender.tag
        lblPersonnel?.text = "\(selectedPersonnel)"
    }
}
