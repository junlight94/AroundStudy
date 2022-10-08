//
//  CategoryItemCollectionViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/07.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell, reusableCollectionView {
    /// 카테고리 이미지
    @IBOutlet weak var imgCategory: UIImageView?
    /// 카테고리 타이틀
    @IBOutlet weak var lblTitle: UILabel?
    
    /**
     * @카테고리 셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle?.text = ""
    }
    
    /**
     * @카테고리 아이템 데이터 설정
     * @creator : coder3306
     * @param title : 카테고리 타이틀(추후에 API 나오면 데이터로 변경)
     */
    public func setData(_ title: String) {
        lblTitle?.text = title
    }
}
