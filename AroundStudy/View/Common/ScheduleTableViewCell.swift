//
//  ScheduleTableViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell, reusableTableView {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var scheduleTitleLabel: UILabel!
    @IBOutlet weak var scheduleDateLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        /// 셀 뷰 코너 라운딩
        cellView.layer.cornerRadius = 12
        /// 셀 뷰 그림자
        cellView.layer.zeplinShadow(color: .black, alpha: 0.1, x: 0, y: 2, blur: 8, spread: 0)
        /// 아이콘뷰 코너 라운딩
        dotView.layer.cornerRadius = 6
        /// 상태 라벨 뷰 코너 라운딩
        statusView.layer.cornerRadius = 8
        
        /// 상태 박스 색상 임시 지정
        statusView.backgroundColor = UIColor(red: 0.58, green: 0.78, blue: 0.04, alpha: 0.17)
        /// 상태 라벨 텍스트 임시 지정
        statusLabel.textColor = UIColor(red: 0.37, green: 0.51, blue: 0.00, alpha: 1.00)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ title: String, date: String, status: String, color: UIColor) {
        /// 아이콘뷰 코너 라운딩
        dotView.layer.cornerRadius = 6
        /// 상태 라벨 뷰 코너 라운딩
        statusView.layer.cornerRadius = 8
        /// 일정 타이틀 변경
        scheduleTitleLabel.text = title
        /// 일정 기간 변경
        scheduleDateLabel.text = date
        /// 상태 변경
        statusLabel.text = status
        /// 아이콘 색상 변경
        dotView.backgroundColor = color
    }
}
