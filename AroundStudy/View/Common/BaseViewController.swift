//  BaseViewController.swift
//  AroundStudy
//
//  Created by Coder3306 on 2022/09/27.

import UIKit
import CoreLocation
import FloatingPanel
import Kingfisher

//******************************************************
//MARK: - Typealias
//******************************************************
/// 테이블 뷰 프로토콜
typealias tableViewExtension = UITableViewDataSource & UITableViewDelegate
/// 컬렉션 뷰 프로토콜
typealias collectionViewExtension = UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
/// 반환값으로 빈 데이터를 넘기는 클로저
typealias voidClosure = () -> ()
/// 반환값으로 True/False를 넘기는 클로저
typealias boolClosure = (Bool?) -> ()
/// 반환값으로 정보를 넘기는 클로저
typealias dataClosure = (Any?) -> ()
/// 반환값으로 번호를 넘기는 클로저
typealias numberClosure = (Int) -> ()
/// 반환값으로 응답값을 넘기는 클로저
typealias responseClosure = ([String: Any]?) -> ()

//MARK: - BaseViewController
class BaseViewController: UIViewController {
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 바텀 마진
    var bottomMargin: CGFloat = 0
    /// 커스텀 네비게이션 바 초기화
    let customNavigationBar = CustomNavigationBar()
    /// 권한 요청
    let authorization = Authorization.shared
    /// 데이터 매니저
    let dataManager = DataManager.shared
    /// 키보드 노티피케이션 설정 스크롤 뷰
    var keyboardTargetView: UIScrollView?
    /// 플로팅 패널 뷰 컨트롤러
    var floatingPanelController: FloatingPanelController?
    /// 플로팅 패널을 적용할 뷰 컨트롤러
    var floatingTargetViewController: UIViewController?
    /// 사용자가 선택한 플로팅 패널의 포지션 저장
    var floatingState: FloatingPanelState?
    /// 플로팅 패널 초기화 여부
    var isInitialCompleteFloatingPanel = false
    
    //******************************************************
    //MARK: - POPUP ID DEFINE
    //******************************************************
    /// 스터디 참여 팝업
    let POPUP_STUDY_JOIN_ID = 1
    /// (테스트) 스터디 탈퇴 팝업
    let POPUP_STUDY_LEAVE_ID = 2
    
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
        removeCache()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        /// 홈 인디케이터 여부에 따라 바텀 마진 설정
        super.viewSafeAreaInsetsDidChange()
        if view.safeAreaInsets.bottom == 0 {
            bottomMargin = 20
        } else {
            bottomMargin = 0
        }
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
    public func setNavigationBar(_ title: String? = nil, leftBarButton: [UIView]? = nil, rightBarButton: [UIView]? = nil, isLeftSetting: Bool = false) {
        /// 기본 네비게이션바 숨기기
        self.navigationController?.navigationBar.isHidden = true
        self.customNavigationBar.backgroundColor = .white
        customNavigationBar.setNavigationBar(title, leftBarButton: leftBarButton, rightBarButton: rightBarButton)
        customNavigationBar.navigationTitleLabel.font = UIFont.setCustomFont(.regular, size: 17)
        
        self.view.addSubview(customNavigationBar)
        customNavigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(customNavigationBar.containerView)
        }
        
        if isLeftSetting && leftBarButton != nil {
            customNavigationBar.navigationTitleLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(customNavigationBar.containerView)
                if let leftItems = customNavigationBar.containerView.subviews.filter({$0.accessibilityIdentifier == "NAVIGATIONLEFTITEMS"}).first {
                    make.leading.equalTo(leftItems.snp.trailing).offset(12)
                }
                if let rightItems = customNavigationBar.containerView.subviews.filter({$0.accessibilityIdentifier == "NAVIGATIONRIGHTITEMS"}).first {
                    make.trailing.lessThanOrEqualTo(rightItems.snp.leading).offset(-12)
                }
            }
        } else if isLeftSetting && leftBarButton == nil {
            customNavigationBar.navigationTitleLabel.font = UIFont.setCustomFont(.semiBold, size: 20)
            customNavigationBar.navigationTitleLabel.snp.remakeConstraints { make in
                make.centerY.equalTo(customNavigationBar.containerView)
                make.leading.equalTo(self.view).offset(20)
                if let rightItems = customNavigationBar.containerView.subviews.filter({$0.accessibilityIdentifier == "NAVIGATIONRIGHTITEMS"}).first {
                    make.trailing.greaterThanOrEqualTo(rightItems.snp.leading).offset(-12)
                }
            }
        }
    }
    
    //******************************************************
    //MARK: - Keyboard
    //******************************************************
    /**
     * @키보드 제스처 설정
     * @creator : coder3306
     */
    private func setTabGesture() {
        let tab = UITapGestureRecognizer(target: self, action: #selector(endEditingKeyboard))
        self.view.addGestureRecognizer(tab)
    }
    
    /**
     * @키보드 노티피케이션 추가
     * @creator : coder3306
     */
    public func setKeyboardNotification(targetView: UIScrollView) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .keyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .keyboardWillHide, object: nil)
        self.keyboardTargetView = targetView
        setTabGesture()
    }
    
    /**
     * @키보드 노티피케이션 삭제
     * @creator : coder3306
     */
    public func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .keyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .keyboardWillHide, object: nil)
    }
    
    //******************************************************
    //MARK: - ProgressBar
    //******************************************************
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
    
    //******************************************************
    //MARK: - Floating
    //******************************************************
    /**
     * @플로팅 패널 뷰 설정
     * @creator : coder3306
     * @param targetViewController : 플로팅 패널로 올릴 뷰 컨트롤러 설정
     * @param targetScrollView : 플로팅 패널 내 스크롤 뷰 설정
     * @param position : 플로팅 패널 초기 노출 위치 설정
     * @param setHalfOnly : 플로팅 패널의 노출 높이를 전체화면 또는 절반으로 설정할때 사용(디폴트: 전체화면)
     */
    public func setupFloatingView(_ targetViewController: UIViewController, targetScrollView: UIScrollView, position: FloatingPanelState, setHalfOnly: Bool = false, halfHeight: CGFloat? = nil) {
        self.isInitialCompleteFloatingPanel = false
        floatingTargetViewController = targetViewController
        floatingPanelController?.customPanelLayout()
        floatingPanelController?.set(contentViewController: targetViewController)
        let layout = CustomFloatingPanelLayout()
        layout.setHalfOnly = setHalfOnly
        if let halfHeight = halfHeight {
            layout.halfHeight = halfHeight
        }
        floatingPanelController?.layout = layout
        floatingPanelController?.invalidateLayout()
        floatingPanelController?.track(scrollView: targetScrollView)
        floatingPanelController?.addPanel(toParent: self)
        floatingPanelController?.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        floatingState = position
        UIView.animate(withDuration: 0.2) {
            self.floatingPanelController?.move(to: position, animated: false)
        } completion: { _ in
            self.isInitialCompleteFloatingPanel = true
        }
    }
}

//MARK: - FloatingPanelControllerDelegate
extension BaseViewController: FloatingPanelControllerDelegate {
    /**
     * @플로팅 패널 상태에 따른 설정
     * @creator : coder3306
     */
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if floatingPanelController?.state == .tip && isInitialCompleteFloatingPanel {
            floatingPanelController?.dismiss(animated: true)
        }
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
    @objc private func endEditingKeyboard() {
        self.view.endEditing(true)
    }

    
    /**
     * @키보드가 나타날 시, 뷰의 y축 수정
     * @creator : coder3306
     * @param notification : Notification
     */
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardTargetView = keyboardTargetView else {
            return
        }
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            keyboardTargetView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.cgRectValue.height, right: 0)
        }
    }
    
    /**
     * @키보드가 사라질 시, 뷰의 y축 원복
     * @creator : coder3306
     * @param notification : Notification
     */
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let keyboardTargetView = keyboardTargetView else {
            return
        }
        keyboardTargetView.contentInset = .zero
    }
    
    /**
     * @Kingfisher 이미지 캐시 삭제
     * @creator : coder3306
     */
    private func removeCache() {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache()
    }
}

//MARK: - 팝업
extension BaseViewController: PopupButtonDelegate {
    /**
     팝업 생성
     > 팝업을 생성하여 띄웁니다.
     - coder: **sanghyeon**
     */
    func showPopup(_ target: UIViewController, id: Int?, title: String, message: String, oneButtonTitle: String, twoButtonTitle: String = "") {
        let popupVC = CommonPopupViewController(nibName: "CommonPopupViewController", bundle: nil)
        popupVC.popupID = id
        popupVC.target = target
        popupVC.modalTransitionStyle = .coverVertical
        popupVC.modalPresentationStyle = .overCurrentContext
        target.present(popupVC, animated: false)
        popupVC.setupPopup(target, title: title, message: message, oneButtonTitle: oneButtonTitle, twoButtonTitle: twoButtonTitle)
        popupVC.delegate = self
    }
    /**
     팝업 클릭 이벤트 처리
     > 클릭한 팝업ID별로 처리 분기
     - coder: **sanghyeon**
     */
    func buttonPressed(_ target: UIViewController?, popupId: Int?, isOk: Bool) {
        guard let popupId = popupId else { return }
        print("팝업 클릭 이벤트! popupId: \(popupId), target: \(target)")
        switch popupId {
        case POPUP_STUDY_JOIN_ID:
            guard let vc = target as? TestViewController else { return }
            vc.popupEvent(isOk)
        case POPUP_STUDY_LEAVE_ID:
            guard let vc = target as? TestViewController else { return }
            vc.popupEventSecond(isOk)
        default: break
        }
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

//MARK: - FloatingPanelController(Custom)
extension FloatingPanelController {
    /**
     * @커스텀 플로팅 패널 레이아웃 설정
     * @creator : coder3306
     */
    func customPanelLayout() {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: -4.0)
        shadow.opacity = 0.15
        shadow.radius = 2
        appearance.shadows = [shadow]
        appearance.cornerRadius = 40
        appearance.backgroundColor = .clear
        appearance.borderColor = .clear
        appearance.borderWidth = 0
        surfaceView.grabberHandlePadding = -15.0
        surfaceView.grabberHandle.backgroundColor = .white
        surfaceView.grabberHandleSize = .init(width: 52, height: 6)

        surfaceView.grabberHandle.isHidden = false
        surfaceView.appearance = appearance
    }
}
