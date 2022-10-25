//
//  MoreUserInfoTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/21.
//

import UIKit

class MoreUserInfoTableViewCell: UITableViewCell {
    private var selectedModify: voidClosure?
    //******************************************************
    //MARK: - Cell Layout
    //******************************************************
    lazy var mainContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileView, noticeView, versionView])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 32
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(borderView).offset(-40)
        }
        return stackView
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "248")
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(0)
            make.height.equalTo(8)
        }
        return view
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
            make.height.equalTo(30)
        }
        return view
    }()
    
    //******************************************************
    //MARK: - Profile Items
    //******************************************************
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.layer.setBorderLayout(radius: 28)
        image.snp.makeConstraints { make in
            make.width.height.equalTo(56)
        }
        return image
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, addressLabel])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.setCustomFont(.semiBold, size: 17)
        label.textColor = UIColor(named: "40")
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "주소123123123123123"
        label.font = UIFont.setCustomFont(.medium, size: 13)
        label.textColor = UIColor(named: "134")
        return label
    }()
    
    private lazy var modifyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "modify"), for: .normal)
        button.addTarget(self, action: #selector(actionModify(_:)), for: .touchUpInside)
        return button
    }()
    
    //******************************************************
    //MARK: - Notice Item
    //******************************************************
    private lazy var noticeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "alert")
        return image
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        label.font = UIFont.setCustomFont(.medium, size: 16)
        label.textColor = UIColor(named: "68")
        return label
    }()
    
    lazy var newNotice: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "N"
        label.font = UIFont.setCustomFont(.semiBold, size: 10)
        label.textColor = .white
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
        }
        view.layer.setBorderLayout(radius: 7)
        view.backgroundColor = UIColor(named: "Main")
        return view
    }()
    
    private lazy var moreNoticeImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "arrow_next"))
        return image
    }()
    
    private lazy var moreNoticeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(actionMoreNotice(_:)), for: .touchUpInside)
        return button
    }()
    
    //******************************************************
    //MARK: - Version Item
    //******************************************************
    private lazy var versionImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "phone")
        return image
    }()
    
    private lazy var version: UILabel = {
        let label = UILabel()
        label.text = "현재버전"
        label.font = UIFont.setCustomFont(.medium, size: 16)
        label.textColor = UIColor(named: "68")
        return label
    }()
    
    private lazy var versionInfo: UILabel = {
        let label = UILabel()
        label.text = "v 2.1"
        label.font = UIFont.setCustomFont(.regular, size: 14)
        label.textColor = UIColor(named: "173")
        return label
    }()
    
    private lazy var updateApp: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("업데이트", for: .normal)
        button.titleLabel?.font = UIFont.setCustomFont(.regular, size: 14)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .black
        button.layer.setBorderLayout(radius: 15)
        button.addTarget(self, action: #selector(actionUpdateApp(_:)), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.width.equalTo(68)
        }
        return button
    }()

    //******************************************************
    //MARK: - Initializer
    //******************************************************
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        print(mainContentStackView.subviews)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        print(mainContentStackView.subviews)
    }
    
    /**
     * @셀 아이템 레이아웃 초기화
     * @creator : coder3306
     */
    private func setupCell() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
        profileView.addSubview(profileImageView)
        profileView.addSubview(nameStackView)
        profileView.addSubview(modifyButton)
        
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.centerY.equalTo(profileView)
            make.leading.equalTo(profileView).offset(16)
        }
        nameStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.centerY.equalTo(profileImageView)
            //FIXME: - 이름 스텍뷰와 수정 아이콘 사이 레이아웃 설정
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        modifyButton.snp.makeConstraints { make in
            make.trailing.equalTo(profileView.snp.trailing).offset(-16)
            make.centerY.equalTo(profileView)
        }
        
        noticeView.addSubview(noticeImage)
        noticeView.addSubview(noticeLabel)
        noticeView.addSubview(newNotice)
        noticeView.addSubview(moreNoticeImage)
        noticeView.addSubview(moreNoticeButton)
        
        noticeImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(noticeView)
        }
        noticeLabel.snp.makeConstraints { make in
            make.leading.equalTo(noticeImage.snp.trailing).offset(12)
            make.centerY.equalTo(noticeImage)
        }
        newNotice.snp.makeConstraints { make in
            make.leading.equalTo(noticeLabel.snp.trailing).offset(6)
            make.width.height.equalTo(14)
            make.centerY.equalTo(noticeLabel)
        }
        moreNoticeImage.snp.makeConstraints { make in
            make.trailing.equalTo(noticeView.snp.trailing)
            make.centerY.equalTo(noticeView)
        }
        moreNoticeButton.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(noticeView)
        }
        
        versionView.addSubview(versionImage)
        versionView.addSubview(version)
        versionView.addSubview(versionInfo)
        versionView.addSubview(updateApp)
        
        versionImage.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(versionView)
        }
        version.snp.makeConstraints { make in
            make.leading.equalTo(versionImage.snp.trailing).offset(12)
            make.centerY.equalTo(versionImage)
        }
        versionInfo.snp.makeConstraints { make in
            make.leading.equalTo(version.snp.trailing).offset(6)
            make.centerY.equalTo(version)
        }
        updateApp.snp.makeConstraints { make in
            make.trailing.equalTo(versionView)
            make.centerY.equalTo(versionView)
        }
    }
    
    /**
     * @프로필 수정 콜백 메서드
     * @creator : coder3306
     * @Return : 프로필 수정하기 버튼이 선택되었을 경우, 선택되었음을 콜백메서드로 전달함.
     */
    public func didSelectModify(_ complete: @escaping voidClosure) {
        self.selectedModify = complete
    }
}

//MARK: - Action
extension MoreUserInfoTableViewCell {
    /**
     * @프로필 수정하기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func actionModify(_ sender: UIButton) {
        selectedModify?()
    }
    
    /**
     * @공지사항 더보기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func actionMoreNotice(_ sender: UIButton) {
        print("MORE NOTICE")
    }
    
    /**
     * @앱 업데이트하기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func actionUpdateApp(_ sender: UIButton) {
        print("UPDATE APP")
    }
}
