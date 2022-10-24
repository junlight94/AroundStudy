//
//  ProfileViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var cameraBackgroundView: UIView?
    @IBOutlet weak var nickNameBorderView: UIView?
    @IBOutlet weak var btnMan: UIButton?
    @IBOutlet weak var btnWoman: UIButton?
    @IBOutlet weak var locationView: UIView?
    @IBOutlet weak var setLocationView: UIView?
    @IBOutlet weak var btnCurrentLocation: UIButton?
    @IBOutlet weak var btnSearch: UIButton?

    weak var delegate: ProfileEditCompleteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initLayout()
    }
    
    private func initLayout() {
        cameraBackgroundView?.layer.setBorderLayout(radius: 14)
        nickNameBorderView?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnMan?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnWoman?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        locationView?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnCurrentLocation?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnSearch?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
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
        
        setNavigationBar("프로필 정보", leftBarButton: [back], rightBarButton: [save], isLeftSetting: true)
    }
}

//MARK: - Action
extension ProfileViewController {
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
}
