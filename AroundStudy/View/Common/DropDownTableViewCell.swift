//
//  DropDownTableViewCell.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/24.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    
    //MARK: IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(_ title: String, subTitle: String = "") {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    func setFont(font: UIFont?) {
        guard let font = font else { return }
        titleLabel.font = font
        subTitleLabel.font = font
    }
}
