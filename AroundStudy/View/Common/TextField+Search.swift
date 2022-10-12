//
//  TextField+Search.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/11.
//

import UIKit

class TextField_Search: UITextField {
    let padding = UIEdgeInsets(top: 9, left: 12, bottom: 9, right: 12)
    let paddingEdit = UIEdgeInsets(top: 9, left: 12, bottom: 9, right: 35)
    
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
    
    private func setup() {
        delegate = self
        clearButtonMode = .whileEditing
        borderStyle = .none
        returnKeyType = .go
        layer.borderColor = UIColor(named: "236")?.cgColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        font = UIFont(name: "Pretendard-Regular", size: 15)
        textColor = UIColor(named: "40")
        tintColor = UIColor(named: "Main")
        backgroundColor = UIColor(named: "244")
        
        if let ph = placeholder?.description {
            attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "134") as Any])
        }
    }
}

extension TextField_Search: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
