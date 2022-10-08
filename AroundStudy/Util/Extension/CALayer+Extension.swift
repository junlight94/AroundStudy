//  CALayer+Extension.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/09/29.
//  레이어 추가설정

import UIKit

extension CALayer {
    /**
     * @제플린 쉐도우 그대로 사용
     * @creator : 이준영
     * @param color : 그림자 색상
     * @param alpha : 그림자 투명도
     * @param x : 그림자 위치 X
     * @param y : 그림자 위치 Y
     * @param blur : 그림자 블러
     * @param spread : 그림자 커스텀 기능 (디폴트 0: nil)
     */
    public func zeplinShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
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
    
    /**
     * @테두리 레이어 설정
     * @creator : coder3306
     * @param radius : 뷰의 모퉁이 부분을 설정한 값 만큼 둥글게 만듦
     * @param bounds : 설정할 뷰의 테두리를 기준으로 서브뷰의 레이아웃을 자를지 설정(default: true)
     * @param width : 뷰의 테두리 부분의 두께 설정
     * @param color : 뷰의 테두리 부분의 색상 설정
     */
    public func setBorderLayout(radius: CGFloat, bounds: Bool = true, width: CGFloat, color: UIColor?) {
        cornerRadius = radius
        masksToBounds = bounds
        borderWidth = width
        borderColor = color?.cgColor
    }
}
