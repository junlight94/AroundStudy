//
//  ScheduleDetailTableViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class ScheduleDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var scheduleWrapperView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var scheduleInnerView: UIView!
    @IBOutlet weak var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        /// 아이콘뷰 코너 라운딩
        iconView.layer.cornerRadius = 3.5
        /// 안의 스케줄 감싸는 뷰 코너 라운딩
        scheduleInnerView.clipsToBounds = true
        scheduleInnerView.layer.cornerRadius = 12
        /// 안의 스케줄 감싸는 뷰 그림자
        scheduleWrapperView.layer.cornerRadius = 12
        scheduleWrapperView.layer.zeplinShadow(color: .black, alpha: 0.09, x: 0, y: 2, blur: 12, spread: 0)
        /// 상태 뷰 코너 라운딩
        statusView.layer.cornerRadius = 8
        
        
        /// 샘플용 프로필 이미지 생성
        let sampleImageView = UIImageView()
        sampleImageView.backgroundColor = UIColor(named: "235")
        sampleImageView.layer.cornerRadius = 16
        sampleImageView.layer.borderWidth = 2
        sampleImageView.layer.borderColor = UIColor.white.cgColor
        sampleImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
        
        
        profileStackView.addArrangedSubview(sampleImageView)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
