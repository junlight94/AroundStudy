//  StudyBannerCollectionViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/04.
//  스터디 배너 컬렉션 셀

import UIKit

class StudyBannerCollectionViewCell: UICollectionViewCell {
    /// 스터디 배너 이미지
    @IBOutlet weak var imgBanner: UIImageView?
    
    /**
     * @셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        imgBanner?.layer.cornerRadius = 4
    }
}
