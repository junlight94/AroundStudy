//
//  TestViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/30.
//

import UIKit

class TestViewController: BaseViewController {

    var cv: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("테스트뷰컨")
        
        let clothesCollectionView: UICollectionView = {
                
                let layout = UICollectionViewFlowLayout()
                
            layout.minimumInteritemSpacing = 15
                
                layout.scrollDirection = .horizontal

                layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
               
                let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.alwaysBounceHorizontal = false
                
                return cv
            }()
        
        cv = clothesCollectionView
        
        let cellNib = UINib(nibName: "PhotoPickerCollectionViewCell", bundle: nil)
        clothesCollectionView.register(cellNib, forCellWithReuseIdentifier: "PhotoPickerCollectionViewCell")
        
        view.addSubview(clothesCollectionView)
        
        clothesCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        clothesCollectionView.delegate = self
        clothesCollectionView.dataSource = self
        
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

    /**
     테스트용 함수
     > 팝업아이디 "POPUP_STUDY_JOIN_ID" 처리 함수
     */
    func popupEvent(_ isOk: Bool) {
        print("popupID: \(POPUP_STUDY_JOIN_ID), isOk: \(isOk)")
    }
    /**
     테스트용 함수
     > 팝업아이디 "POPUP_STUDY_LEAVE_ID" 처리 함수
     */
    func popupEventSecond(_ isOk: Bool) {
        print("떠날거에요!!! 팝업은!!! popupID: \(POPUP_STUDY_JOIN_ID), isOk: \(isOk)")
    }
}

//MARK: - 권한 요청 처리
extension TestViewController {
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


extension TestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cv?.dequeueReusableCell(withReuseIdentifier: "PhotoPickerCollectionViewCell", for: indexPath) as? PhotoPickerCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
    
}
