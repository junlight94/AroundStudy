//
//  ProfileViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    /// 프로필 이미지
    @IBOutlet weak var profileImage: UIImageView?
    /// 프로필 이미지 옆 카메라 백그라운드 뷰
    @IBOutlet weak var cameraBackgroundView: UIView?
    /// 닉네임 표기 테두리 뷰
    @IBOutlet weak var nickNameBorderView: UIView?
    /// 성별 버튼 리스트
    @IBOutlet var btnGender: [UIButton]?
    /// 현재 설정된 위치의 정보를 담고 있는 뷰
    @IBOutlet weak var locationView: UIView?
    /// 현재 설정된 위치가 없을경우, 위치를 설정해주는 뷰(디폴트: 히든처리)
    @IBOutlet weak var setLocationView: UIView?
    /// 위치 설정) 현재 위치로 설정
    @IBOutlet weak var btnCurrentLocation: UIButton?
    /// 위치 설정) 직접 검색
    @IBOutlet weak var btnSearch: UIButton?

    /// 프로필 재설정 완료 델리게이트
    weak var delegate: ProfileEditCompleteDelegate?
    
    /**
     * @프로필 뷰 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initLayout()
    }
    
    /**
     * @프로필 뷰 레이아웃 설정
     * @creator : coder3306
     */
    private func initLayout() {
        cameraBackgroundView?.layer.setBorderLayout(radius: 14)
        nickNameBorderView?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        locationView?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnCurrentLocation?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnSearch?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnGender?.forEach({
            $0.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
            $0.setTitleColor(UIColor(named: "236"), for: .normal)
            $0.setTitleColor(UIColor(named: "40"), for: .selected)
            if $0.isSelected {
                $0.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "Main"))
            }
        })
    }
    
    /**
     * @네비게이션 바 초기화
     * @creator : coder3306
     */
    private func initNavigationBar() {
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "back"), for: .normal)
        back.addTarget(self, action: #selector(actionNaviBack(_:)), for: .touchUpInside)
        let save = UIButton(type: .custom)
        save.setTitle("저장하기", for: .normal)
        save.addTarget(self, action: #selector(actionSave(_:)), for: .touchUpInside)
        save.titleLabel?.font = UIFont.setCustomFont(.regular, size: 15)
        save.setTitleColor(UIColor(named: "94"), for: .normal)
        
        let naviItems = NavigationBarItems(title: "프로필 정보", leftBarButton: [back], rightBarButton: [save], isLeftSetting: true)
        setNavigationBar(naviItems: naviItems)
    }
}

//MARK: - Action
extension ProfileViewController {
    /**
     * @프로필 수정 뒤로가기
     * @저장하지 않고 뒤로가기 선택 시 팝업 노출
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func actionNaviBack(_ sender: UIButton) {
        //FIXME: - 데이터의 수정된 부분이 있는지 검사 후 수정되었을 시에 팝업 띄우기, 그외에는 바로 나가게 설정
        showPopup(self, id: 0, title: "프로필 수정 나가기", message: "수정한 정보들이 저장되지 않았습니다.\n저장하지 않고 나가시겠습니까?", oneButtonTitle: "나가기", twoButtonTitle: "취소")
    }
    
    /**
     * @프로필 수정사항 저장하기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func actionSave(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        delegate?.didCompleteEdit()
    }
    
    /**
     * @성별 변경
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionSetGender(_ sender: UIButton) {
        if sender.isSelected {
            return
        }
        btnGender?.forEach({
            if sender.tag == $0.tag {
                $0.layer.setBorderLayout(radius: 8,width: 1, color: UIColor(named: "Main"))
                $0.isSelected = true
            } else {
                $0.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
                $0.isSelected = false
            }
        })
    }
}
