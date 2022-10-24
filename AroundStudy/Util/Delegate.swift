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
