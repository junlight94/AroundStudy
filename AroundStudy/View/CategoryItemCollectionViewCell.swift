//
//  CategoryItemCollectionViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/07.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell, reusableCollectionView {
    @IBOutlet weak var lblTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setData(_ title: String) {
        lblTitle?.text = title
    }
}
