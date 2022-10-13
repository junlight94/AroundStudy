//  SelectVoteSegmentTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/12.
//

import UIKit
class SelectStartEndSegmentTableViewCell: UITableViewCell, reusableTableView {
    /// 시작일/종료일 선택 세그먼트 컨트롤
    @IBOutlet weak var startEndSegments: CustomSegmentControl?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

