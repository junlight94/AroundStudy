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
        
        /// 위치 권한 요청
        authorizationLocation()
        /// 알림 권한 요청
        authorization.requestNotificationAuthorization() { result in
            self.dataManager.isAuthorizationPushNotification = result
            if let _ = result {
                print("*** ViewController.swift, 알림 권한: 허용")
            } else {
                print("*** ViewController.swift, 알림 권한: 거부")
            }
        }
        /// 카메라 권한 요청
        authorization.requestCameraAuthorization() { result in
            self.dataManager.isAuthorizationCamera = result
            if result {
                print("*** ViewController.swift, 카메라 권한: 허용")
            } else {
                print("*** ViewController.swift, 카메라 권한: 거부")
            }
        }
        /// 포토 라이브러리 권한 요청
        authorization.requestPhotoLibraryAuthorization() { result in
            self.dataManager.isAuthorizationPhotoLibrary = result
            if let result = result {
                if result {
                    print("*** ViewController.swift, 포토 라이브러리 권한: 허용")
                } else {
                    print("*** ViewController.swift, 포토 라이브러리 권한: 거부")
                }
            } else {
                print("*** ViewController.swift, 포토 라이브러리 권한: 설정하지 않음")
            }
        }
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
            case 0, 1: /// 위치 권한 설정 아직 안 됨, 사용자에게 권한을 요청할 수 있음
                authorization.requestLocationAuthorization()
            case 2: /// 유저가 위치 권한을 거부하였음, 사용자에게 권한을 요청할 수 없음, 설정으로 유도 시킴
                /// 설정으로 이동시킬 코드 작성
                break
            default: /// 그 외의 경우, 딱히 처리할 게 있을까요?
                break
            }
        }
    }
}
