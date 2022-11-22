//  OpenStudyStep3ViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/15.
//  스터디 개설 3단계 뷰 컨트롤러

import UIKit
import FloatingPanel

class OpenStudyStep3ViewController: BaseViewController {
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 스터디 개설 컨텐츠가 담겨있는 스크롤 뷰
    @IBOutlet weak var scrollContentView: UIScrollView?
    /// 장소 선택 버튼
    @IBOutlet weak var btnPlace: UIButton?
    /// 시간 선택 뷰
    @IBOutlet weak var viewTime: UIView?
    /// 스터디 개설하기
    @IBOutlet weak var btnFinish: UIButton?
    /// 스터디 진행방식 선택 버튼 리스트
    @IBOutlet var aryProcess: [UIButton]?
    /// 스터디 날짜 선택 버튼 리스트
    @IBOutlet var aryWeekday: [UIButton]?
    /// 스터디 선택된 인원 라벨
    @IBOutlet weak var tfPersonnel: UITextField?
    /// 장소선택 뷰
    @IBOutlet weak var viewPlace: UIView?
    /// 선택한 시간 라벨
    @IBOutlet weak var lblTime: UILabel?
    /// 선택한 장소 라벨
    @IBOutlet weak var lblSelectPlace: UILabel?
    /// 선택한 장소를 보여주는 뷰
    @IBOutlet weak var viewSelectedPlace: UIView?
    /// 장소 진행방식을 나타내는 아이콘
    @IBOutlet weak var imgPlaceIcon: UIImageView?
    
    /// 선택된 인원
    private var selectedPersonnel = 2
    /// 스터디 진행방식 온라인/오프라인 구분
    private var isOffline = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let scrollView = scrollContentView {
            setKeyboardNotification(targetView: scrollView)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotification()
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
            $0.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        })
        btnPlace?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        aryWeekday?.forEach({
            $0.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        })
        viewTime?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnFinish?.layer.setBorderLayout(radius: 8)
        viewSelectedPlace?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        tfPersonnel?.text = "\(selectedPersonnel)"
        viewPlace?.isHidden = true
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
        if tfPersonnel?.isFirstResponder == true {
            tfPersonnel?.resignFirstResponder()
        }
        
        if viewPlace?.isHidden == true {
            viewPlace?.isHidden = false
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
        viewSelectedPlace?.isHidden = true
        btnPlace?.isHidden = false
    }
    
    /**
     * @장소 선택
     * @param sender : UIButton
     * @creator : coder3306
     */
    @IBAction private func actionSelectPlace(_ sender: UIButton) {
        if tfPersonnel?.isFirstResponder == true {
            tfPersonnel?.resignFirstResponder()
        }
        if isOffline {
            let vc = SearchAddressViewController(nibName: "SearchAddressViewController", bundle: nil)
            vc.didSelectAddress { address in
                if let address = address as? String {
                    self.viewSelectedPlace?.isHidden = false
                    self.imgPlaceIcon?.image = UIImage(named: "location")
                    self.viewSelectedPlace?.bringSubviewToFront(self.view)
                    self.btnPlace?.isHidden = true
                    self.lblSelectPlace?.text = address
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = OpenStudySelectOnlinePlaceViewController(nibName: "OpenStudySelectOnlinePlaceViewController", bundle: nil)
            floatingPanelController = FloatingPanelController(delegate: self)
            vc.didSelectOnlinePlace { place in
                if let place = place as? [String] {
                    let onlinePlace = place.joined(separator: ", ")
                    self.imgPlaceIcon?.image = UIImage(named: "etcOnline")
                    self.viewSelectedPlace?.isHidden = false
                    self.viewSelectedPlace?.bringSubviewToFront(self.view)
                    self.btnPlace?.isHidden = true
                    self.lblSelectPlace?.text = onlinePlace
                }
            }
            setupFloatingView(vc, targetScrollView: UIScrollView(), position: .half, setHalfOnly: true, halfHeight: 298)
        }
    }
    
    /**
     * @요일 선택
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionSelectWeekday(_ sender: UIButton) {
        if tfPersonnel?.isFirstResponder == true {
            tfPersonnel?.resignFirstResponder()
        }
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
        if tfPersonnel?.isFirstResponder == true {
            tfPersonnel?.resignFirstResponder()
        }
        let vc = OpenStudySelectTimeViewController(nibName: "OpenStudySelectTimeViewController", bundle: nil)
        vc.selectedTimeHandler { [weak self] time in
            if let time = time as? String {
                self?.lblTime?.text = time
            }
        }
        floatingPanelController = FloatingPanelController(delegate: self)
        setupFloatingView(vc, targetScrollView: UIScrollView(), position: .half, setHalfOnly: true, halfHeight: 346)
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
        tfPersonnel?.text = "\(selectedPersonnel)"
    }
    
    @IBAction private func actionDeletePlace(_ sender: UIButton) {
        self.lblSelectPlace?.text = ""
        self.btnPlace?.isHidden = false
        self.viewSelectedPlace?.sendSubviewToBack(self.view)
        self.viewSelectedPlace?.isHidden = true
    }
}

//MARK: - UITextFieldDelegate
extension OpenStudyStep3ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text as? NSString
        let str = string.replacingOccurrences(of: "\n", with: "")
        let newText = text?.replacingCharacters(in: range, with: str) ?? ""
        if let textCount = Int(newText) {
            if textCount > 100 {
                self.selectedPersonnel = 100
                tfPersonnel?.text = "100"
                return false
            } else if textCount < 2 {
                self.selectedPersonnel = 2
                tfPersonnel?.text = "2"
                return false
            }
            self.selectedPersonnel = textCount
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if tfPersonnel?.text == "" {
            self.selectedPersonnel = 2
            tfPersonnel?.text = "2"
        }
        return true
    }
}
