//  CALayer+Extension.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/09/29.
//  레이어 추가설정

import UIKit

extension CALayer {
    /**
     * @쉐도우 설정
     * @creator : coder3306
     * @param offset : 그림자의 위치
     * @param color : 그림자 색상
     * @param radius : 그림자 블러
     * @param opacity : 그림자 투명도
     * @param path : 그림자 모양 커스텀
     */
    public func setShadow(offset: CGSize = CGSize(width: 0, height: 4), color: CGColor = UIColor.black.cgColor, radius: CGFloat = 8, opacity: Float = 0.12, rect: CGRect = CGRect.zero) {
        masksToBounds = false
        shadowOffset = offset
        shadowColor = color
        shadowRadius = radius
        shadowOpacity = opacity
        //FIXME: - 쉐도우 처리 오류
//        shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
    }
    
    /**
     * @쉐도우 삭제
     * @creator : coder3306
     */
    public func removeShadow() {
        shadowOffset = CGSize.zero
        shadowColor = UIColor.clear.cgColor
        shadowRadius = CGFloat.zero
        shadowOpacity = .zero
    }
}
