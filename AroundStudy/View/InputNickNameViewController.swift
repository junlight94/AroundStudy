//
//  InputNickNameViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/10.
//

import UIKit

class InputNickNameViewController: BaseViewController {

    @IBOutlet weak var btnNext: Button_General!
    @IBOutlet weak var textField: TextField_General!
    
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
        setNavigationBar("정보입력", leftBarButton: [backButton], rightBarButton: nil, isLeftSetting: false)
        
        btnNext.isEnabled = false
        
        textField.addTarget(self, action: #selector(editingText), for: .editingChanged)
        
        textField.text = DataManager.shared.userInfo.nickName
    }
    
    //MARK: - Selector Function
    @objc func btnBackPressed(_ sender: UIButton) {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    @objc func editingText(textField: UITextField) {
        if let text = textField.text {
            if text.count > 2{
                btnNext.isEnabled = true
            } else {
                btnNext.isEnabled = false
            }
        }
        
    }
    
    //MARK: - IBAction Function
    @IBAction func btnNextPressed(_ sender: Any) {
        if let text = textField.text {
        }
        let vc = InputGenderViewController(nibName: "InputGenderViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK: - Extension
