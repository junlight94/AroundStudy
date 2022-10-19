//  UIFont+Extension.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/14.
//  폰트 추가설정

import UIKit

extension UIFont {
    /// 프리탠다드 폰트체 타입 열거
    public enum Pretendard: String {
        case bold = "Bold"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "SemiBold"
    }
    
    /**
     * @커스텀 폰트 설정
     * @creator : coder3306
     * @param type : 커스텀 폰트의 타입
     * @param size : 폰트 사이즈
     * @Return : 설정된 폰트 반환
     */
    static func setCustomFont(_ type: Pretendard, size: CGFloat) -> UIFont? {
        return UIFont(name: "Pretendard-\(type)", size: size)
    }
}
