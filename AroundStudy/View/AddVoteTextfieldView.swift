//
//  AddVoteTextfieldView.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/12.
//

import UIKit

class AddVoteTextfieldView: UIView {
    
    //MARK: Delegate
    var delegate: VoteRemoveProtocol?
    
    //MARK: Inspector Properties
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var isRequired: Bool {
        get {
            return self.isRequired
        }
        set {
            if newValue {
                addSubview(textfield)
                textfield.snp.makeConstraints { make in
                    make.leading.trailing.equalTo(self).inset(16)
                    make.centerY.equalTo(self)
                }
            } else {
                addSubview(textfield)
                addSubview(minusButton)
                minusButton.setImage(UIImage(named: "minus"), for: .normal)
                textfield.snp.makeConstraints { make in
                    make.leading.equalTo(self).offset(16)
                    make.trailing.equalTo(minusButton.snp.leading).offset(-16)
                    make.centerY.equalTo(self)
                }
                minusButton.snp.makeConstraints { make in
                    make.trailing.equalTo(self).offset(-16)
                    make.width.height.equalTo(36)
                    make.centerY.equalTo(self)
                }
            }
        }
    }
    
    //MARK: View Component
    let minusButton = UIButton(type: .custom)
    let textfield = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        textfield.placeholder = "투표 항목을 입력해주세요."
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
    }
    
    @objc func didTapMinusButton() {
        delegate?.removeVoteTextfield(view: self)
    }

}
