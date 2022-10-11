//
//  HotStudyCollectionViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/11.
//

import UIKit

class HotStudyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbSubCategory: UILabel!
    @IBOutlet weak var lbSubPeople: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var viewSubCategory: UIView!
    @IBOutlet weak var viewSubPeople: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCategory.layer.cornerRadius = 5
        viewSubCategory.layer.cornerRadius = 5
        viewSubPeople.layer.cornerRadius = 5
    }

}
