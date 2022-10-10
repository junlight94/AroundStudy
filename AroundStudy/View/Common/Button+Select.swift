//
//  Button+Select.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/10.
//

import UIKit

class Button_Select: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = UIColor(named: "Main")?.withAlphaComponent(0.7)
            } else {
                backgroundColor = UIColor.white
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setTitleColor(UIColor(named: "40"), for: .normal)
                layer.borderColor = UIColor(named: "Main")?.cgColor
            } else {
                setTitleColor(UIColor(named: "134"), for: .normal)
                layer.borderColor = UIColor(named: "236")?.cgColor
            }
        }
    }
    
    func setupView() {
        titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 15)
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "236")?.cgColor
        setTitleColor(UIColor(named: "134"), for: .normal)
        setTitleColor(.white, for: .highlighted)
        layer.cornerRadius = 8
    }
    
}
