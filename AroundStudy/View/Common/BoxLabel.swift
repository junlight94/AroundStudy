//
//  BoxLabel.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/01.
//

import UIKit
import SnapKit

class BoxLabel: UIView {
    let label = UILabel()
    
    /**
     라벨 텍스트
     */
    var text: String = "" {
        willSet {
            label.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        //MARK: ViewDefine
        let boxView = UIView()
        
        
        //MARK: ViewPropertyManual
        label.textColor = UIColor(named: "109")
        label.font = UIFont(name: "Pretendard-Medium", size: 12)
        label.sizeToFit()
        boxView.backgroundColor = UIColor(named: "235")
        boxView.layer.cornerRadius = 4
        boxView.sendSubviewToBack(self)
        
        
        //MARK: AddSubView
        addSubview(boxView)
        boxView.addSubview(label)
        
        
        //MARK: ViewContraints
        boxView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.leading.trailing.equalTo(boxView).inset(6)
            make.top.bottom.equalTo(boxView).inset(3)
        }
        
        
        //MARK: ViewAddTarget
        
        
        //MARK: Delegate
    }
}
