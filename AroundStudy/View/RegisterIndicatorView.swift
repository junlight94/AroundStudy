//
//  RegisterIndicatorView.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/03.
//

import UIKit

class RegisterIndicatorView: UIView {

    let oneStepView = UIView()
    let twoStepView = UIView()
    let threeStepView = UIView()
    
    var currentStep: Int = 1 {
        willSet {
            switch newValue {
            case 1:
                oneStepView.backgroundColor = UIColor(named: "Main")
            case 2:
                oneStepView.backgroundColor = UIColor(named: "Main")
                twoStepView.backgroundColor = UIColor(named: "Main")
            case 3:
                oneStepView.backgroundColor = UIColor(named: "Main")
                twoStepView.backgroundColor = UIColor(named: "Main")
                threeStepView.backgroundColor = UIColor(named: "Main")
            default: break
            }
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
        let indicatorStackView = UIStackView()
        indicatorStackView.axis = .horizontal
        indicatorStackView.distribution = .fillEqually
        indicatorStackView.spacing = 4
        
        
        
        //MARK: ViewPropertyManual
        oneStepView.backgroundColor = UIColor(named: "236")
        twoStepView.backgroundColor = UIColor(named: "236")
        threeStepView.backgroundColor = UIColor(named: "236")
        
        
        //MARK: AddSubView
        addSubview(indicatorStackView)
        indicatorStackView.addArrangedSubview(oneStepView)
        indicatorStackView.addArrangedSubview(twoStepView)
        indicatorStackView.addArrangedSubview(threeStepView)
        
        
        //MARK: ViewContraints
        indicatorStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
