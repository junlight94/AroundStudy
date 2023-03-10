//  CustomSegmentControl.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/12.
//  세그먼트 컨트롤 커스텀 설정

import UIKit

class CustomSegmentControl: UISegmentedControl {
    /**
     * 레이아웃 초기화
     * - Author: coder3306
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    /**
     * @제스처 설정
     * @creator : coder3306
     */
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        super.gestureRecognizerShouldBegin(gestureRecognizer)
        return true
    }
    
    /**
     * @레이아웃 설정
     * @creator : coder3306
     */
    private func setLayout() {
        let segmentStringSelected: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "Pretendard-Medium", size: 15)!,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2079616189, green: 0.2079616189, blue: 0.2079616189, alpha: 1)
        ]
        let segmentStringNormal: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont(name: "Pretendard-Medium", size: 15)!,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6745098039, green: 0.6745098039, blue: 0.6745098039, alpha: 1)
        ]

        setTitleTextAttributes(segmentStringNormal, for: .normal)
        setTitleTextAttributes(segmentStringSelected, for: .selected)
        setTitleTextAttributes(segmentStringNormal, for: .highlighted)
        
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        let cornerRadius = bounds.height / 2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners

        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.image = UIImage()
            foregroundImageView.clipsToBounds = true
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            foregroundImageView.layer.cornerRadius = bounds.height / 2 + 3
            foregroundImageView.layer.borderWidth = 8
            foregroundImageView.layer.borderColor = #colorLiteral(red: 0.931889832, green: 0.931889832, blue: 0.9353198409, alpha: 1)
            foregroundImageView.layer.maskedCorners = maskedCorners
        }
    }
}
