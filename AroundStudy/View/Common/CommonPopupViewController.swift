//
//  CommonPopupViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/02.
//

import UIKit

protocol PopupProtocol {
    func didTapOneButton()
}

class CommonPopupViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupImageView: UIImageView!
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var popupDesc: UILabel!
    
    @IBOutlet weak var oneButton: Button_General!
    @IBOutlet weak var twoButton: UIButton!
    
    /// 팝업의 고유 값
    var popupID: String = ""
    
    /// 델리게이트 설정
    var delegate: PopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if popupID == "" {
            /// 팝없값이 넘어오지 않은 경우 그대로 창을 닫아버림
            self.dismiss(animated: false)
        }
    }

    @IBAction func didTapOneButton(_ sender: Any) {
        delegate?.didTapOneButton()
    }
    
    @IBAction func didTapTwoButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}

extension CommonPopupViewController {
    /**
     초기 레이아웃 설정
     > 전반적인 팝업 뷰컨트롤러의 기본 레이아웃을 설정합니다.
     */
    /**
     * @ 초기 레이아웃 설정
     * coder : sanghyeon
     */
    func setupView() {
        //MARK: ViewDefine
        let safeArea = view.safeAreaLayoutGuide
        
        
        //MARK: ViewPropertyManual
        /// 백그라운드 색상 반투명 처리
        view.backgroundColor = .black.withAlphaComponent(0.5)
        /// 팝업 뷰 속성
        popupView.layer.cornerRadius = 12
        /// 팝업 타이틀 속성
        popupTitle.sizeToFit()
        popupTitle.textColor = UIColor(named: "28")
        /// 팝업 메세지 속성
        popupDesc.sizeToFit()
        popupDesc.textColor = UIColor(named: "51")
    }
    
    /**
     팝업 생성
     > 팝업을 생성합니다
     - popupID : 팝업의 고유값
     - title : 팝업 타이틀
     - message: 팝업 상세 메세지
     - oneButtonTitle : 기본 FilledButton, 빈 값일 경우 확인으로 표시됩니다.
     - twoButtonTitle : 보조버튼, 빈 값일경우 보이지 않습니다.
     */
    func setupPopup(_ popupID: String, title: String, message: String, oneButtonTitle: String, twoButtonTitle: String = "") {
        self.popupID = popupID
        self.popupTitle.text = title
        self.popupDesc.text = message
        self.oneButton.setTitle(oneButtonTitle, for: .normal)
        if twoButtonTitle == "" { /// 투버튼 없을때
            self.twoButton.removeFromSuperview()
            self.oneButton.snp.remakeConstraints { make in
                make.top.equalTo(popupDesc.snp.bottom).offset(26)
                make.leading.trailing.equalTo(popupView).inset(28)
                make.bottom.bottom.equalTo(popupView).offset(-20)
            }
        } else { /// 투버튼 있을때
            self.twoButton.setTitle(twoButtonTitle, for: .normal)
        }
    }
}
