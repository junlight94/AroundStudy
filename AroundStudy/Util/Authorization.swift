//
//  Authorization.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/28.
//

import UIKit
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
            if let error = error {
                print("[ERROR] Authorization.swift, requestNotificationAuthorization\n - error: \(error)")
                self.dataManager.isAuthorizationLocation = nil
                completion(nil)
            } else {
                if granted {
                    self.dataManager.isAuthorizationLocation = true
                    completion(true)
                } else {
                    self.dataManager.isAuthorizationLocation = false
                    completion(false)
                }
            }
        }
    }
    
    
    //MARK: - 권한 요청 응답 처리

}
