//  LocationManager.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/16.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    /// 위치 관리 매니저 싱글톤 인스턴스
    static let shared = LocationManager()
    /// 로케이션 관리자
    var locationManager: CLLocationManager?
    /// 현재 위치
    var currentLocation: CLLocation?
    /// 검색된 위치 전달 핸들러
    var searchLocation: dataClosure?
    
    private override init() { }
    
    deinit {
        destroyLocationManager()
    }
    
    /**
     * @리버스지오코딩된 위치주소 획득
     * @creator : coder3306
     * @Return : 조회된 데이터를 클로저로 데이터 전달
     */
    public func getReverseGeoCodeLocation(_ complete: @escaping dataClosure) {
        self.searchLocation = nil
        self.searchLocation = complete
        setupLocationManager()
    }
    
    /**
     * @위치권한 관리자 설정
     * @creator : coder3306
     * @Return :
     */
    private func setupLocationManager() {
        if locationManager != nil {
            if #available(iOS 14.0, *) {
                self.updateLocation(locationManager?.authorizationStatus)
            } else {
                self.updateLocation(CLLocationManager.authorizationStatus())
            }
            return
        }
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        if #available(iOS 14.0, *) {
            self.updateLocation(locationManager?.authorizationStatus)
        } else {
            self.updateLocation(CLLocationManager.authorizationStatus())
        }
    }
    
    /**
     * @위치 설정 초기화
     * @creator : coder3306
     */
    private func destroyLocationManager() {
        locationManager?.delegate = nil
        currentLocation = nil
    }
    
    /**
     * @위치권한 상태에 따른 검색 설정
     * @creator : coder3306
     * @param status : 위치권한 상태
     */
    private func updateLocation(_ status: CLAuthorizationStatus?) {
        guard let status = status else { return }
        switch status {
            case .notDetermined:
                requestAuthorization()
            case .denied, .restricted:
                print("권한 재요청 로직필요함.")
            case .authorizedAlways, .authorizedWhenInUse:
                requestCurrentLocation()
            default:
                print(LocationErrors.unknown)
        }
    }
    
    /**
     * @위경도 -> 시/도 + 구/군으로 변경
     * @creator : coder3306
     * @param location : 현재위치
     */
    private func reverseGeocoding(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placeMark, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let placeMark = placeMark?.first {
                if let gu = placeMark.locality, let dong = placeMark.subLocality {
                    self?.searchLocation?("\(gu) \(dong)")
                } else {
                    self?.searchLocation?(placeMark.name ?? "unknown")
                }
            }
        }
    }
    
    /**
     * @위치권한 요청
     * @creator : coder3306
     */
    private func requestAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    /**
     * @현재위치 요청
     * @creator : coder3306
     */
    private func requestCurrentLocation() {
        locationManager?.requestLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    /**
     * @위치권한 변경 알림
     * @creator : coder3306
     * @param manager : 위치권한 관리자
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                requestCurrentLocation()
            case .notDetermined, .denied, .restricted:
                //FIXME: 권한변경알림 코드 작성필요함
                print("권한 변경 알림")
            default:
                print(LocationErrors.unknown)
        }
    }
    
    /**
     * @위치권한 획득 후처리
     * @creator : coder3306
     * @param manager : 관리자
     * @param locations : 획득한 위치 정보
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            //FIXME: - 위경도로 접근 필요할 시, 분기처리 필요함.
            reverseGeocoding(location)
        }
    }
    
    /**
     * @위치 작업 중 에러 수신
     * @creator : coder3306
     * @param manager : 위치권한 관리자
     * @param error : 발생된 에러
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

enum LocationErrors: String {
    case denied = "위치 정보 접근 권한이 거절되었습니다."
    case notDetermined = "위치 정보 접근 권한이 허가되지 않았습니다."
    case invaildLocation = "알 수 없는 위치정보"
    case reverseGeocodingFailed = "현재 위치의 정보를 알 수 없습니다."
    case unknown = "알 수 없는 오류"
}
