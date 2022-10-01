//
//  Button+General.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/28.
//

import UIKit

class Button_General: UIButton {
    
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
                backgroundColor = UIColor(named: "40")?.withAlphaComponent(0.9)
            } else {
                backgroundColor = UIColor(named: "40")
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                setTitleColor(.white, for: .normal)
                backgroundColor = UIColor(named: "40")
            } else {
                setTitleColor(UIColor(named: "212"), for: .normal)
                backgroundColor = UIColor(named: "248")
            }
        }
    }
    
    func setupView() {
        titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 17)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        backgroundColor = UIColor(named: "40")
        layer.cornerRadius = 8
    }
    
}
