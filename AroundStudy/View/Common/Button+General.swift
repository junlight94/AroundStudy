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
                
            } else {
                
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                
            } else {
                
            }
        }
    }
    
    func setupView() {
        
    }
    
}
