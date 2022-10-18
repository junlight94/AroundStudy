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
    }
    
    /**
     컬렉션뷰 셀 설정
     > coder : **sanghyeon**
     */
    func setInitCell(color: UIColor) {
        /// 셀 초기화
        circleView.backgroundColor = .white
        checkmarkImageView.isHidden = true
        colorView.layer.cornerRadius = 16
        circleView.layer.cornerRadius = 7
        checkmarkImageView.isHidden = true
        colorView.backgroundColor = color
    }
    
    /**
     컬렉션뷰 셀렉트 함수
     > coder : **sanghyeon**
     */
    func selectCell() {
        circleView.backgroundColor = .clear
        checkmarkImageView.isHidden = false
        checkmarkImageView.tintColor = .white
    }

}
