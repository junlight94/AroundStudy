//
//  TextField+General.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class TextField_General: UITextField {
    let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    let paddingEdit = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 35)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: paddingEdit)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: (self.frame.width - 18) - 17, y: (self.frame.height / 2) - 9, width: 18, height: 18)
    }
    
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                layer.borderColor = UIColor(named: "40")?.cgColor
                textColor = UIColor(named: "40")
            } else {
                layer.borderColor = UIColor(named: "236")?.cgColor
                textColor = UIColor(named: "236")
            }
        }
    }
    
    private func setup() {
        delegate = self
        clearButtonMode = .whileEditing
        borderStyle = .none
        layer.borderColor = UIColor(named: "236")?.cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        font = UIFont(name: "Pretendard-Regular", size: 15)
        textColor = UIColor(named: "40")
        tintColor = UIColor(named: "Main")
        
//        if let ph = placeholder?.description {
//            attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "236") as Any])
//        }
    }
}

extension TextField_General: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor(named: "40")?.cgColor
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.layer.borderColor = UIColor(named: "236")?.cgColor
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
