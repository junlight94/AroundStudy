//
//  UIView+Extension.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/15.
//

import UIKit

extension UIView {
    /**
     * @폰 해상도에 따른 사이즈 계산
     * @creater : coder3306
     * @param size : 현재 아이템의 사이즈
     * @Return : 계산된 아이템 사이즈
     */
    private func getPhoneSize(_ size: CGFloat) -> CGFloat {
        let targetHeight = UIScreen.main.bounds.height
        //MARK: IPHONE11
        let standardSize = CGSize(width: 414, height: 896)
        let newValue = ((targetHeight / standardSize.height))
        let roundValue = roundf(Float(newValue * size))
        return CGFloat(roundValue)
    }
    
    /**
     * @폰트 리사이징
     * @creater : coder3306
     * @param fontArray : 라벨 버튼 배열
     */
    public func setResizeFont() {
        if type(of: self) == UILabel.self {
            if let label = self as? UILabel {
                let size = label.font.pointSize
                let resizeFont = label.font.withSize(getPhoneSize(size))
                label.font = resizeFont
            }
        } else if type(of: self) == UIButton.self {
            if let button = self as? UIButton {
                if let size = button.titleLabel?.font.pointSize {
                    if let resizefont = button.titleLabel?.font.withSize(getPhoneSize(size)) {
                        button.titleLabel?.font = resizefont
                    }
                }
            }
            
        }
    }
}
