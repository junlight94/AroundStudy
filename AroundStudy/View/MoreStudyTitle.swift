//  MoreStudyTitle.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/24.
//  더보기 - 스터디 찾기 타이틀

import UIKit

class MoreStudyTitle: UITableViewCell {
    lazy var studyTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.setCustomFont(.medium, size: 16)
        label.textColor = UIColor(named: "40")
        return label
    }()
    
    private lazy var showAllStudy: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(UIColor(named: "134"), for: .normal)
        button.titleLabel?.font = UIFont.setCustomFont(.regular, size: 15)
        button.addTarget(self, action: #selector(showAllStudy(_:)), for: .touchUpInside)
        return button
    }()
    
    //******************************************************
    //MARK: - Initializer
    //******************************************************
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /**
     * @셀 설정
     * @creator : coder3306
     */
    private func setupCell() {
        contentView.addSubview(studyTitle)
        contentView.addSubview(showAllStudy)
        
        studyTitle.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(20)
            make.leading.equalTo(contentView).offset(20)
            make.bottom.equalTo(contentView).offset(-15)
        }
        
        showAllStudy.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.bottom.trailing.equalTo(contentView).offset(-20)
            make.centerY.equalTo(contentView)
        }
    }
    
    /**
     * @스터디 전체보기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func showAllStudy(_ sender: UIButton) {
        print("전체보기")
    }
}
