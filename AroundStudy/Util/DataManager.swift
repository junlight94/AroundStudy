//
//  DataManager.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/28.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    let KEY_PERMISSION_PUSH = "KEY_PERMISSION_PUSH"
    
    
    internal var isPermissionPush: Bool {
        didSet {
            UserDefaults.standard.set(isPermissionPush, forKey: KEY_PERMISSION_PUSH)
            
        }
    }
    
    private init() {
        isPermissionPush = UserDefaults.standard.bool(forKey: KEY_PERMISSION_PUSH)
    }
    
    func reset() {
        
    }
}
