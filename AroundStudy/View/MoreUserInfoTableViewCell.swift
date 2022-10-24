//
//  MoreUserInfoTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/21.
//

import UIKit

class MoreUserInfoTableViewCell: UITableViewCell, reusableTableView {
    //******************************************************
    //MARK: - Cell Layout
    //******************************************************
    lazy var mainContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileView, noticeView, versionView])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 28
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(contentView)
        }
        return stackView
    }()
    
    private lazy var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "248")
        view.layer.setBorderLayout(radius: 12)
        view.snp.makeConstraints { make in
            make.height.equalTo(88)
        }
        return view
    }()
    
    private lazy var noticeView: UIView = {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        return view
    }()
    
    private lazy var versionView: UIView = {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        return view
    }()
    
    //******************************************************
    //MARK: - Items
    //******************************************************
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.leading.centerX.equalTo(profileView)
        }
        return image
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, addressLabel])
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.centerX.equalTo(profileImageView)
        }
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.setCustomFont(.semiBold, size: 17)
        label.textColor = UIColor(named: "40")
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "주소123123123123123"
        label.font = UIFont.setCustomFont(.medium, size: 13)
        label.textColor = UIColor(named: "134")
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
