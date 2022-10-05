//
//  StudyInfoGridCollectionViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class StudyInfoGridCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbMember: UILabel!
    
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewMember: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMain.layer.cornerRadius = 8
        viewLocation.layer.cornerRadius = 4
        viewMember.layer.cornerRadius = 4
    }
    
    func setupCell(_ title: String, location: String, memberCount: Int, image: String? = nil) {
        lbInfo.text = title
        lbLocation.text = location
        lbMember.text = "\(memberCount)"
        
    }
    
}
