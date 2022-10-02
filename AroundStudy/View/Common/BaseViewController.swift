//  BaseViewController.swift
//  AroundStudy
//
//  Created by Coder3306 on 2022/09/27.

import UIKit
import CoreLocation

//******************************************************
//MARK: - Typealias
//******************************************************
/// 테이블 뷰 프로토콜
typealias tableViewExtension = UITableViewDataSource & UITableViewDelegate
/// 컬렉션 뷰 프로토콜
typealias collectionViewExtension = UICollectionViewDataSource & UICollectionViewDelegate
/// 반환값으로 빈 데이터를 넘기는 클로저
typealias voidClosure = () -> ()
/// 반환값으로 True/False를 넘기는 클로저
typealias boolClosure = (Bool?) -> ()
/// 반환값으로 정보를 넘기는 클로저
typealias dataClosure = (Any) -> ()
/// 반환값으로 번호를 넘기는 클로저
typealias numberClosure = (Int) -> ()

//MARK: - BaseViewController
class BaseViewController: UIViewController {
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 커스텀 네비게이션 바 초기화
    let customNavigationBar = CustomNavigationBar()
    /// 권한 요청
    let authorization = Authorization.shared
    /// 데이터 매니저
    let dataManager = DataManager.shared
    
    //******************************************************
    //MARK: - LifeCycle
    //******************************************************
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
    
    //******************************************************
    //MARK: - Method
    //******************************************************
    /**
     * @커스텀 네비게이션 바 생성 처리
     * @creator : coder3306
     * @param title : 네비게이션 바 타이틀
     * @param leftBarButton : 네비게이션 바 왼쪽 버튼 리스트
     * @param rightbarButton : 네비게이션 바 오른쪽 버튼 리스트
     */
    public func setNavigationBar(_ title: String? = nil, leftBarButton: [UIView]? = nil, rightBarButton: [UIView]? = nil) {
        /// 기본 네비게이션바 숨기기
        self.navigationController?.navigationBar.isHidden = true
        self.customNavigationBar.backgroundColor = .white
        customNavigationBar.setNavigationBar(title, leftBarButton: leftBarButton, rightBarButton: rightBarButton)
        
        self.view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(customNavigationBar.containerView)
        }
    }
    
    /**
     * @키보드 제스처 설정
     * @creator : coder3306
     */
    public func setTabGesture() {
        let tab = UITapGestureRecognizer(target: self, action: #selector(endEditingKeyboard(_:)))
        self.view.addGestureRecognizer(tab)
    }
    
    /**
     * @키보드 노티피케이션 추가
     * @creator : coder3306
     */
    public func setKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .keyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .keyboardWillHide, object: nil)
    }
    
    /**
     * @키보드 노티피케이션 삭제
     * @creator : coder3306
     */
    public func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .keyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .keyboardWillHide, object: nil)
    }
    
    /**
     * @프로그래스바 노출처리
     * @creator : coder3306
     */
    public func showProgressBar() {
    }
    
    /**
     * @프로그래스바 히든처리
     * @creator : coder3306
     */
    public func hideProgressBar() {
    }
}

//MARK: - Action
extension BaseViewController {
    /**
     * @네비게이션 뒤로가기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc public func popToView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     * @키보드 종료
     * @creator : coder3306
     */
    @objc private func endEditingKeyboard(_ edit: UIView) {
        self.view.endEditing(true)
    }

    
    /**
     * @키보드가 나타날 시, 뷰의 y축 수정
     * @creator : coder3306
     * @param notification : Notification
     */
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            //FIXME: - 로직변경필요
            self.view.frame.origin.y -= keyboardFrame.cgRectValue.height
        }
    }
    
    /**
     * @키보드가 사라질 시, 뷰의 y축 원복
     * @creator : coder3306
     * @param notification : Notification
     */
    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    /**
     팝업 생성
     > 팝업을 생성하여 띄웁니다.
     - coder: **sanghyeon**
     */
    func showPopup(_ target: UIViewController, title: String, message: String, oneButtonTitle: String, twoButtonTitle: String = "") {
        let popupVC = CommonPopupViewController(nibName: "CommonPopupViewController", bundle: nil)
        popupVC.modalTransitionStyle = .coverVertical
        popupVC.modalPresentationStyle = .overCurrentContext
        target.present(popupVC, animated: false)
        popupVC.setupPopup(title, message: message, oneButtonTitle: oneButtonTitle, twoButtonTitle: twoButtonTitle)
        popupVC.delegate = target as! any PopupProtocol
    }

}

//MARK: - 권한 요청 처리
extension BaseViewController: CLLocationManagerDelegate {
    /// 위치 권한 처리 (권한 요청값이 바뀔때 델리게이트 호출)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("*** BaseViewController.swift, locationManagerDidChangeAuthorization - status: \(manager.authorizationStatus.rawValue)")
        dataManager.isAuthorizationLocation = manager.authorizationStatus.rawValue
    }
}
