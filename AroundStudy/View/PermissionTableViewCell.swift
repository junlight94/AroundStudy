//
//  PermissionTableViewCell.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/04.
//

import UIKit

class PermissionTableViewCell: UITableViewCell {
    @IBOutlet weak var iconWrapperView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var permissionTitleLabel: UILabel!
    @IBOutlet weak var permissionDescLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 이미지 뷰 감싸는 뷰 코너 라운딩
        iconWrapperView.layer.cornerRadius = 22
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     셀 설정 - coder : **sanghyeon**
     */
    func setupCell(_ title: String, desc: String, image: String) {
        permissionTitleLabel.text = title
        permissionDescLabel.text = desc
        iconImageView.image = UIImage(named: image)
    }
}
