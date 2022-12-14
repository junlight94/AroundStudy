//
//  InputLocationViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/10.
//

import UIKit
import CoreLocation

class InputLocationViewController: BaseViewController {
    
    @IBOutlet weak var btnNext: Button_General!
    @IBOutlet weak var lbCurrentLocation: UILabel!
    
    var locationManager = CLLocationManager()
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - General Function
    func setupView() {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(btnBackPressed), for: .touchUpInside)
        
        let naviItems = NavigationBarItems(title: "정보입력", leftBarButton: [backButton], rightBarButton: nil, isLeftSetting: false)
        setNavigationBar(naviItems: naviItems)
        
        btnNext.isEnabled = false
        
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            print("위치 업데이트!")
//            print("위도 : \(location.coordinate.latitude)")
//            print("경도 : \(location.coordinate.longitude)")
//        }
//    }
//        
//    // 위치 가져오기 실패
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("error")
//    }
    
    //MARK: - Selector Function
    @objc func btnBackPressed(_ sender: UIButton) {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - IBAction Function
    @IBAction func btnNextPressed(_ sender: Any) {
        let vc = InputGenderViewController(nibName: "InputGenderViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCurrentLocationPressed(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        
        if let location = locationManager.location {
            let findlocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(findlocation, preferredLocale: locale) { [weak self] placemarks, _ in
                guard let placemarks = placemarks,
                      let address = placemarks.last
                else { return }
                DispatchQueue.main.async {
                    if let locality = address.locality, let subLocality = address.subLocality {
                        self?.lbCurrentLocation.text = "\(locality) \(subLocality)"
                    }
                }
            }
        }
        
    }
    

}
//MARK: - extension
