//
//  BaseViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/27.
//

import UIKit
import CoreLocation

class BaseViewController: UIViewController {
    let authorization = Authorization.shared
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Delegate
        /// 로케이션매니저 델리게이트
        authorization.locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

extension BaseViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("*** BaseViewController.swift, locationManagerDidChangeAuthorization - status: \(manager.authorizationStatus.rawValue)")
        dataManager.isAuthorizationLocation = manager.authorizationStatus.rawValue
    }
}
