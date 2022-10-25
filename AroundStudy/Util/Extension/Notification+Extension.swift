//  Notification+Extension.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/09/29.
//

import UIKit

//MARK: Notification.Name
extension Notification.Name {
    /// 키보드 노출 알림
    static let keyboardWillShow = UIResponder.keyboardWillShowNotification
    /// 키보드 종료 알림
    static let keyboardWillHide = UIResponder.keyboardWillHideNotification
    /// 포그라운드 진입 알림
    static let enterForeground = UIApplication.willEnterForegroundNotification
    /// 백그라운드 진입 알림
    static let enterBackground = UIApplication.willResignActiveNotification
    /// 스케줄 팝업 뷰 호출
    static let showSchedulePopup = NSNotification.Name("showSchedulePopup")
    /// 투표 날짜 팝업 뷰 호출
    static let showAddVoteView = NSNotification.Name("showAddVoteView")
}
