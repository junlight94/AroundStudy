//
//  VoteDetailItemView.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/03.
//

import UIKit

class VoteDetailItemView: UIView {
    
    let checkmarkImageView = UIImageView()
    let voteTitleLabel = UILabel()
    let voteCountLabel = UILabel()
    let voteProgressView = UIProgressView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        DispatchQueue.main.async {
            self.setupView()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        DispatchQueue.main.async {
//            self.setupView()
//        }
    }

    func setupView() {
        let containerView = UIView()
        
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = UIColor(named: "212")
        
        voteTitleLabel.text = "좋아요"
        voteTitleLabel.textColor = UIColor(named: "68")
        voteTitleLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        
        voteCountLabel.text = "10명"
        voteCountLabel.textColor = UIColor(named: "68")
        voteCountLabel.font = UIFont(name: "Pretendard-Medium", size: 15)
        
        voteProgressView.progressViewStyle = .default
        voteProgressView.clipsToBounds = true
        voteProgressView.subviews[1].clipsToBounds = true
        voteProgressView.layer.cornerRadius = 5
        voteProgressView.layer.sublayers![1].cornerRadius = 5
        voteProgressView.trackTintColor = UIColor(named: "248")
        voteProgressView.progressTintColor = UIColor(named: "Main")
        
        voteProgressView.progress = 0.33
        
        containerView.addSubview(checkmarkImageView)
        containerView.addSubview(voteTitleLabel)
        containerView.addSubview(voteCountLabel)
        containerView.addSubview(voteProgressView)
        addSubview(containerView)
        
        DispatchQueue.main.async {
            print(containerView)
            containerView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.top.bottom.equalToSuperview()
            }
            self.checkmarkImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.leading.equalTo(containerView)
                make.width.height.equalTo(24)
            }
            self.voteTitleLabel.snp.makeConstraints { make in
                make.leading.equalTo(self.checkmarkImageView.snp.trailing).offset(5)
                make.centerY.equalTo(self.checkmarkImageView)
            }
            self.voteCountLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview()
                make.centerY.equalTo(self.checkmarkImageView)
            }
            self.voteProgressView.snp.makeConstraints { make in
                make.top.equalTo(self.voteTitleLabel.snp.bottom).offset(9)
                make.leading.equalTo(self.voteTitleLabel)
                make.trailing.equalTo(self.voteCountLabel)
                make.height.equalTo(10)
            }
        }

    }
}
