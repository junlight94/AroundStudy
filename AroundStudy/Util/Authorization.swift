//
//  Authorization.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/28.
//

import UIKit
import AVFoundation
import Photos
import CoreLocation
import UserNotifications

class Authorization {
    //MARK: Singleton Pattern
    static let shared = Authorization()
    
    //MARK: Declaration
    let locationManager = CLLocationManager()
    let dataManager = DataManager.shared
}

extension Authorization {
    
    //MARK: - 권한 요청
    
    /**
    위치 권한 요청
     > 사용자에게 위치 권한을 허용할 것인지 묻습니다.
     */
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /**
     알림 권한 요청
     > 사용자에게 푸시 알림을 받을 것인지에 대한 권한을 허용할 것인지 묻습니다.
     */
    func requestNotificationAuthorization(completion: @escaping (Bool?) -> ()) {
        let center = UNUserNotificationCenter.current()
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        center.requestAuthorization(options: authOptions) { granted, error in
            if let _ = error {
                self.dataManager.isAuthorizationLocation = nil
                completion(nil)
            } else {
                self.dataManager.isAuthorizationLocation = granted
                completion(granted)
            }
        }
    }
    
    /**
     카메라 권한 요청
     > 사용자에게 카메라 권한을 허용할 것인지 묻습니다.
     */
    func requestCameraAuthorization(completion: @escaping (Bool) -> ()) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion(granted)
        }
    }
    
    /**
     포토 라이브러리 권한 요청
     > 사용자에게 카메라 권한을 허용할 것인지 묻습니다.
        - true : 사용자가 권한을 승인하여 포토 라이브러리에 접근할 수 있습니다.
        - false : 사용자가 권한을 거부하여 포토라이브러리에 접근할 수 없습니다.
        - nil : 사용자가 권한 승인 여부를 결정하지 않았습니다.
        - Returns:Optional(Bool)
     */
    func requestPhotoLibraryAuthorization(completion: @escaping (Bool?) -> ()) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { result in
            switch result {
            case .authorized, .limited:
                completion(true)
            case .restricted, .denied:
                completion(false)
            default:
                completion(nil)
            }
        }
    }
    


}
