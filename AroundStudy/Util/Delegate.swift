//
//  Delegate.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/28.
//

import UIKit

/**
 뷰를 업데이트 해주는 Delegate
 */
protocol UpdateViewDelegate: AnyObject {
    func updateView()
}

/**
 팝업 버튼 액션을 위한 Delegate
 */
protocol PopupButtonDelegate: AnyObject {
    func buttonPressed(_ target: UIViewController?, popupId: Int?, isOk: Bool)
}

/**
 투표 등록 중 투표항목 제거를 위한 Delegate
 > coder : **sanghyeon**
 */
protocol VoteRemoveProtocol {
    func removeVoteTextfield(view: UIView)
}

/**
 드롭다운(큰) 제어를 위한 델리케이트
 > coder : **sanghyeon**
 */
@objc protocol DropDownLargeDelegate {
    /// 드롭다운 동작 버튼
    @objc func dropDownTargetButton() -> UIButton
    /// 드롭다운 출력 표시
    @objc optional func maximumDropCount() -> Int
    /// 드롭다운 항목 높이
    @objc optional func dropDownHeight() -> CGFloat
    /// 드롭다운 인디케이터 표시 여부
    @objc optional func showIndicator() -> Bool
    /// 드롭다운 아이템 폰트 설정
    @objc optional func itemFont() -> UIFont?
    /// 드롭다운 버튼 타이틀 변경 여부
    @objc func changeDropDownButtonTitle() -> Bool
    /// 드롭다운 아이템
    @objc func dropDownItem() -> [Any]
    /// 드롭다운 타겟 뷰 중첩 여부
    @objc func overOffset() -> Bool
    /// 드롭다운 아이템 클릭시 이벤트
    @objc func tappedDropDown(item: String)
    /// 드롭다운 활성화시 버튼 이미지
    @objc optional func activeDropDownButtonImage() -> UIImage?
    /// 드롭다운 비활성화시 버튼 이미지
    @objc optional func disableDropDownButtonImage() -> UIImage?
    
}

/**
 * @테이블뷰 재사용 설정을 위한 프로토콜
 * @creator : coder3306
 */
protocol reusableTableView {
    /// 재사용 셀 식별자
    static var reuseIdentifier: String { get }
    /// 재사용 셀 파일 이름
    static var nibName: String { get }
    /**
     * @커스텀 xib를 등록하는 메서드
     * @creator : coder3306
     * @param targetView : xib를 등록할 테이블 뷰
     */
    static func registerXib(targetView: UITableView)
    /**
     * @재사용 셀 등록 설정
     * @creator : coder3306
     * @param targetView : 재사용 셀을 등록할 테이블 뷰
     */
    static func dequeueReusableCell(targetView: UITableView) -> Self?
}

extension reusableTableView where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static func registerXib(targetView: UITableView) {
        let nib = UINib(nibName: self.nibName, bundle: nil)
        targetView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    static func dequeueReusableCell(targetView: UITableView) -> Self? {
        if let cell = targetView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) {
            return cell as? Self ?? nil
        }
        return nil
    }
}

/**
 * @컬렉션뷰 재사용 설정을 위한 프로토콜
 * @creator : coder3306
 */
protocol reusableCollectionView {
    /// 재사용 셀 식별자
    static var reuseIdentifier: String { get }
    /// 재사용 셀 파일 이름
    static var nibName: String { get }
    /**
     * @커스텀 xib 등록
     * @creator : coder3306
     * @param targetView : xib를 등록할 컬렉션 뷰
     */
    static func registerXib(targetView: UICollectionView)
    /**
     * @재사용 셀 등록 설정
     * @creator : coder3306
     * @param targetView : 재사용 셀을 등록할 컬렉션 뷰
     */
    static func dequeueReusableCell(targetView: UICollectionView, indexPath: IndexPath) -> Self?
}

extension reusableCollectionView where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var nibName: String {
        return String(describing: Self.self)
    }
    
    static func registerXib(targetView: UICollectionView) {
        let nib = UINib(nibName: self.nibName, bundle: nil)
        targetView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    static func dequeueReusableCell(targetView: UICollectionView, indexPath: IndexPath) -> Self? {
        let cell = targetView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath)
        return cell as? Self
    }
}

/**
 * @프로필 수정완료 델리게이트
 * @creator : coder3306
 */
protocol ProfileEditCompleteDelegate: AnyObject {
    func didCompleteEdit()
}
