//
//  SearchHistoryCollectionViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/11.
//

import UIKit

class SearchHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnOnClick: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.layer.cornerRadius = 8
    }

}
