//
//  StudyInfoCollectionViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class StudyInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbMember: UILabel!
    
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewMember: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLocation.layer.cornerRadius = 4
        viewMember.layer.cornerRadius = 4
    }

}
