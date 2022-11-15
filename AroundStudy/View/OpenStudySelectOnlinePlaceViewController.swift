//
//  OpenStudySelectOnlinePlaceViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/15.
//

import UIKit

class OpenStudySelectOnlinePlaceViewController: BaseViewController {
    /// 장소 선택 버튼 리스트
    @IBOutlet var aryOnlinePlace: [UIButton]?
    /// 선택한 날짜 초기화 버튼
    @IBOutlet weak var btnClear: UIButton?
    /// 선택완료 버튼
    @IBOutlet weak var btnComplete: UIButton?
    
    /// 선택한 날짜 저장 튜플
    var selectedPlace: [(String, Bool)] = [
        (OnlinePlace.zoom.code, false)
        , (OnlinePlace.googleMeet.code, false)
        , (OnlinePlace.whaleOn.code, false)
        , (OnlinePlace.discord.code, false)
        , (OnlinePlace.webex.code, false)
        , (OnlinePlace.teams.code, false)
        , (OnlinePlace.skype.code, false)
        , (OnlinePlace.etc.code, false)
    ]
    /// 선택한 장소 정보를 전달할 데이터 객체 선언
    var placeInfo: dataClosure?
    
    /// 선택한 날짜
    enum OnlinePlace: Int {
        case zoom
        case googleMeet
        case whaleOn
        case discord
        case webex
        case teams
        case skype
        case etc
        
        var code: String {
            switch self {
                case .zoom: return "줌"
                case .googleMeet: return "구글미트"
                case .whaleOn: return "웨일온"
                case .discord: return "디스코드"
                case .webex: return "웹엑스"
                case .teams: return "팀즈"
                case .skype: return "스카이프"
                case .etc: return "기타"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    /**
     * @선택된 장소 콜백 메서드
     * @creator : coder3306
     * @Return : 선택된 장소를 후처리 한 후, 콜백메서드로 전달함.
     */
    public func didSelectOnlinePlace(_ complete: @escaping dataClosure) {
        self.placeInfo = complete
    }
    
    /**
     * @레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        aryOnlinePlace?.enumerated().forEach({
            $1.tag = $0
        })
        btnClear?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnComplete?.layer.setBorderLayout(radius: 8)
    }
}

//MARK: - Action
extension OpenStudySelectOnlinePlaceViewController {
    /**
     * @선택한 장소 정보 초기화
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionClear(_ sender: UIButton) {
        aryOnlinePlace?.forEach({
            $0.isSelected = false
        })
        
        for i in 0 ..< selectedPlace.count {
            selectedPlace[i].1 = false
        }
    }
    
    /**
     * @장소 선택완료
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionComplete(_ sender: UIButton) {
        var place = [String]()
        selectedPlace.forEach({
            if $0.1 == true {
                place.append($0.0)
            }
        })
        placeInfo?(place)
        self.dismiss(animated: true)
    }
    
    /**
     * @장소 선택
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionSelectPlace(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        selectedPlace[sender.tag].1 = sender.isSelected
    }
}
