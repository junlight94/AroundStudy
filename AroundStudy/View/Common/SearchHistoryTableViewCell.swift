//
//  SearchHistoryTableViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnOnClick: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
