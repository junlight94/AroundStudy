//
//  ColorSetCollectionViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class ColorSetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 컬러 뷰 코너 라운딩
        colorView.layer.cornerRadius = 18
        /// 동그란 뷰 코너 라운딩
        circleView.layer.cornerRadius = 9
        /// 체크마크 이미지 기본적으로 숨김
        checkmarkImageView.isHidden = true
    }
    
    func selectCell() {
        circleView.backgroundColor = .clear
        checkmarkImageView.isHidden = false
        checkmarkImageView.tintColor = .white
    }

}
