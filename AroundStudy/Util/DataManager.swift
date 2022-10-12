//
//  DataManager.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/28.
//

import UIKit
import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    
    //MARK: - Define Authorization Name
    let KEY_AUTHORIZATION_LOCATION = "KEY_AUTHORIZATION_LOCATION" /// 위치 권한
    let KEY_AUTHORIZATION_PUSH_NOTIFICATION = "KEY_AUTHORIZATION_PUSH_NOTIFICATION" /// 푸시 노티피케이션 권한
    let KEY_AUTHORIZATION_CAMERA = "KEY_AUTHORIZATION_CAMERA" /// 푸시 노티피케이션 권한
    let KEY_AUTHORIZATION_PHOTO_LIBRARY = "KEY_AUTHORIZATION_PHOTO_LIBRARY" ///  포토 라이브러리 권한
    
    //MARK: - Authorization Property
    /**
     사용자의 위치 권한 상태 가져오기
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
     사용자의 알림 권한 상태 가져오기
     */
    internal var isAuthorizationPushNotification: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: KEY_AUTHORIZATION_PUSH_NOTIFICATION)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KEY_AUTHORIZATION_PUSH_NOTIFICATION)
        }
    }

    /**
     사용자의 카메라 권한 상태 가져오기
     */
    internal var isAuthorizationCamera: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: KEY_AUTHORIZATION_CAMERA)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KEY_AUTHORIZATION_CAMERA)
        }
    }
    
    /**
     사용자의 포토 라이브러리 권한 상태 가져오기
     */
    internal var isAuthorizationPhotoLibrary: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: KEY_AUTHORIZATION_PHOTO_LIBRARY)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: KEY_AUTHORIZATION_PHOTO_LIBRARY)
        }
    }
    
    /**
     Realm 연결
     */
    internal func realmConfiguration() -> Realm.Configuration {
        var realmConfig = Realm.Configuration.defaultConfiguration
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)
        
        if let applicationSupportDirectoryPath = path.first {
            let realmPath = applicationSupportDirectoryPath.appending("/default.realm")
            realmConfig.fileURL = URL(fileURLWithPath: realmPath)
            return realmConfig
        }
        return realmConfig
    }
    
    /**
     특정한 경우 applicationSupport를 생성 하지 않는 문제가 있어 없는 경우 폴더를 수동으로 생성하는 함수
     */
    internal func createApplicationSupport() {
        print(#function)
        let fileManager = FileManager.default
        
        guard let applicationSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            return
        }
        
        if !fileManager.fileExists(atPath: applicationSupportURL.path) {
            do {
                try fileManager.createDirectory(atPath: applicationSupportURL.path,
                                                withIntermediateDirectories: false,
                                                attributes: nil)
            } catch {
                print("Error creating log folder in documents dir: \(error)")
            }
        }
    }
    
    
    private init() {

    }
    
    func reset() {
        
    }
}
