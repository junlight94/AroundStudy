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
    @IBOutlet weak var lbCategory: UILabel!
    
    
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewMember: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMain.layer.cornerRadius = 8
        
        viewCategory.backgroundColor = .init(named: "40")?.withAlphaComponent(0.65)
        viewCategory.layer.cornerRadius = 5
        viewLocation.layer.cornerRadius = 4
        viewMember.layer.cornerRadius = 4
    }
    
    func setupCell(_ title: String, category: String, location: String, memberCount: Int, image: String? = nil) {
        lbCategory.text = category
        lbInfo.text = title
        lbLocation.text = location
        lbMember.text = "\(memberCount)"
        
    }
    
}
