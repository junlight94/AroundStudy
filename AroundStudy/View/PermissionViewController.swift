//
//  PermissionViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/04.
//

import UIKit
import SnapKit

class PermissionViewController: UIViewController {

    let permission: [Int: [String]] = [
        0: ["알림", "채팅 알림을 위한 권한", "notifications"],
        1: ["위치", "내 주변 스터디 검색을 위한 권한", "location"],
        2: ["카메라", "채팅, 프로필 사진 촬영을 위한 권한", "camera"],
        3: ["갤러리", "채팅, 프로필 사진 등록을 위한 권한", "gallery"]
    ]
    
    @IBOutlet weak var okButton: Button_General!
    @IBOutlet weak var okButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var permissionTableView: UITableView!
    @IBOutlet weak var tableViewWrapperView: UIView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tableWrapperViewHeight = tableViewWrapperView.frame.height
        
        if tableWrapperViewHeight > 320 {
            tableViewHeightConstraint.constant = 320
            permissionTableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            permissionTableView.isScrollEnabled = false
        } else {
            tableViewHeightConstraint.constant = tableWrapperViewHeight
            permissionTableView.isScrollEnabled = true
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        if view.safeAreaInsets.bottom == 0 {
            okButtonBottomConstraint.constant = 20
        } else {
            okButtonBottomConstraint.constant = 0
        }
        view.layoutIfNeeded()
    }
}

//MARK: - other Functions
extension PermissionViewController {
    /**
     * @ 초기 레이아웃 설정
     * coder : sanghyeon
     */
    func setupView() {
        //MARK: ViewPropertyManual
        /// 테이블뷰 코너 라운딩
        permissionTableView.layer.cornerRadius = 12
        
        
        //MARK: ViewAddTarget
        let permissionCellNib = UINib(nibName: "PermissionTableViewCell", bundle: nil)
        permissionTableView.register(permissionCellNib, forCellReuseIdentifier: "PermissionTableViewCell")
        
        
        //MARK: Delegate
        permissionTableView.delegate = self
        permissionTableView.dataSource = self
    }
    @IBAction func didTapOKButton(_ sender: Any) {
        let vc = SocialLoginViewController(nibName: "SocialLoginViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - TableView
extension PermissionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permission.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(indexPath: indexPath)
    }
    
    
    /**
     셀 설정, cellForRow 대체 함수
     - coder : **sanghyeon**
     */
    func setupCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = permissionTableView.dequeueReusableCell(withIdentifier: "PermissionTableViewCell", for: indexPath) as? PermissionTableViewCell else { return UITableViewCell()}
        let targetPermission = permission[indexPath.row]!
        cell.setupCell(targetPermission[0], desc: targetPermission[1], image: targetPermission[2])
        return cell
    }
    
    
}
