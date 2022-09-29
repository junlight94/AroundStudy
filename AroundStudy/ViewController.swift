//
//  ViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/27.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("스플래쉬 화면")
        
        /// 위치권한 요청
        authorizationLocation()
    }
}

//MARK: - 권한 요청 처리
extension ViewController {
    /**
     위치 권한 처리
     > 현재 설정된 위치 권한에 따라 로직 구현
     */
    func authorizationLocation() {
        if let isAuthorizationLocation = dataManager.isAuthorizationLocation as? Int {
            print("*** ViewController.swift, viewDidLoad  - isAuthorizationLocation Binding: \(isAuthorizationLocation)")
            switch isAuthorizationLocation {
            case 0: /// 위치 권한 설정 아직 안 됨
                authorization.requestLocationAuthorization()
            case 1...2: /// 유저가 위치 권한을 거부하였음, 설정으로 이동 시킴
                /// 설정으로 이동시킬 코드 작성
                break
            default: /// 그 외의 경우, 딱히 처리할 게 있을까요?
                break
            }
        }
    }
}
