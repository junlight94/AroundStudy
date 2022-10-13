//
//  KeywordCollectionViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/13.
//

import UIKit

class KeywordCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lbKeyword: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.layer.cornerRadius = 8
    }

}
