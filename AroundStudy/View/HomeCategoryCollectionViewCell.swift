//
//  HomeCategoryCollectionViewCell.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/05.
//

import UIKit

class HomeCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 카테고리 이미지 뷰 코너 라운딩
        ///let categoryIconHeight = categoryIconImageView.frame.height
        categoryIconImageView.layer.cornerRadius = 8 /// categoryIconHeight / 2
    }

}
