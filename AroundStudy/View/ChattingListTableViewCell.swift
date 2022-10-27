//
//  ChattingListTableViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/27.
//

import UIKit

class ChattingListTableViewCell: UITableViewCell {

    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbMinute: UILabel!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var lbCount: UILabel!
    @IBOutlet weak var btnOnClick: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewCount.layer.cornerRadius = 9
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
