//
//  MemberProfileCollectionViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class MemberProfileCollectionViewCell: UICollectionViewCell {

    /// 프로필 이미지 뷰
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 25
    }
    
    /**
     셀 높이 가져오기
     > coder : sanghyeon
     */
    func getCellSize() -> CGFloat {
        return profileNameLabel.frame.maxY
    }

}
