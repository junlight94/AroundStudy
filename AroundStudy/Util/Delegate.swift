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
