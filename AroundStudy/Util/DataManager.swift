//
//  DataManager.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/28.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    //MARK: - Define Authorization Name
    let KEY_AUTHORIZATION_LOCATION = "KEY_AUTHORIZATION_LOCATION" /// 위치 권한
    let KEY_AUTHORIZATION_PUSH_NOTIFICATION = "KEY_AUTHORIZATION_PUSH_NOTIFICATION" /// 푸시 노티피케이션 권한
    
    //MARK: - Authorization Property
    /**
     사용자의 위치권한 상태 가져오기
     */
    internal var isAuthorizationLocation: Any? {
        get {
            return UserDefaults.standard.integer(forKey: KEY_AUTHORIZATION_LOCATION)
        }
        set {
            UserDefaults.standard.set(newValue as? Int32 ?? -1, forKey: KEY_AUTHORIZATION_LOCATION)
        }
    }
    /**
     사용자의 알림권한 상태 가져오기
     */
    internal var isAuthorizationPushNotification: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: KEY_AUTHORIZATION_PUSH_NOTIFICATION)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KEY_AUTHORIZATION_PUSH_NOTIFICATION)
        }
    }

    
    private init() {

    }
    
    func reset() {
        
    }
}
