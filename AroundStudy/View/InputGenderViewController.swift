//
//  InputGenderViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/10.
//

import UIKit

class InputGenderViewController: BaseViewController {
    
    @IBOutlet weak var btnNext: Button_General!
    @IBOutlet weak var btnMan: Button_Select!
    @IBOutlet weak var btnWoman: Button_Select!
    
    lazy var selectGender = [btnMan, btnWoman]
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - General Function
    func setupView() {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(btnBackPressed), for: .touchUpInside)
        let naviItems = NavigationBarItems(title: "정보입력", leftBarButton: [backButton], rightBarButton: nil, isLeftSetting: false)
        setNavigationBar(naviItems: naviItems)
        
        btnNext.isEnabled = false
    }
    
    //MARK: - Selector Function
    @objc func btnBackPressed(_ sender: UIButton) {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - IBAction Function
    @IBAction func btnNextPressed(_ sender: Any) {
        let vc = InputLocationViewController(nibName: "InputLocationViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSelectGenderPressed(_ sender: UIButton) {
        print(#function, sender.tag)
        
        for i in 0..<selectGender.count {
            if i == sender.tag {
                selectGender[i]?.isSelected = true
            } else {
                selectGender[i]?.isSelected = false
            }
        }
        
        btnNext.isEnabled = true
    }
    
}
