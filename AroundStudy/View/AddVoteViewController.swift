//
//  AddVoteViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/09.
//

import UIKit

class AddVoteViewController: BaseViewController, VoteRemoveProtocol {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var voteStackView: UIStackView!
    /// 투표 설정 버튼
    @IBOutlet weak var anonymousButton: UIButton!
    @IBOutlet weak var multipleButton: UIButton!
    @IBOutlet weak var deadlineButton: UIButton!
    /// 마감 시간 라벨
    @IBOutlet weak var deadlineLabel: UILabel!
    
    
    /// 백버튼
    let backButton = UIButton(type: .custom)
    /// 오른쪽 완료 버튼
    let completeButton = UIButton(type: .system)
    
    /// 투표 옵션 변수
    var isAnonymouse: Bool = false
    var isMultiple: Bool = false
    var isDeadline: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 초기 레이아웃 설정
        setupView()
    }
}

//MARK: - Layout & Functions
extension AddVoteViewController {
    /**
     초기 레이아웃 설정
     > coder : **sanghyeon**
     */
    func setupView() {
        /// 네비게이션바 세팅
        /// 백버튼 설정
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.tintColor = UIColor(named: "40")
        completeButton.setTitle("완료", for: .normal)
        completeButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 15)
        completeButton.tintColor = UIColor(named: "94")
        setNavigationBar("투표 올리기", leftBarButton: [backButton], rightBarButton: [completeButton], isLeftSetting: true)
        
        completeButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
    }
    
    /**
     항목 추가 버튼 클릭
     > coder : **sanghyeon**
     */
    @IBAction func didTapFieldPlusButton(_ sender: Any) {
        let voteTextFieldView = AddVoteTextfieldView()
        voteTextFieldView.isRequired = false
        voteTextFieldView.borderWidth = 1
        voteTextFieldView.borderColor = UIColor(named: "236")!
        voteTextFieldView.cornerRadius = 8
        voteTextFieldView.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        voteTextFieldView.delegate = self
        voteStackView.addArrangedSubview(voteTextFieldView)
    }
    
    /**
     투표 등록 버튼 클릭
     > coder : **sanghyeon**
     */
    @objc func didTapCompleteButton() {
        /// 스택뷰 안의 텍스트 필드 값 배열로 만들기
        var voteTextArray: [String] = []
        for subview in voteStackView.subviews {
            if let view = subview as? AddVoteTextfieldView, let voteString = view.textfield.text {
                if voteString != "" {
                    voteTextArray.append(voteString)
                }
            }
        }
        print("입력한 텍스트: \(voteTextArray)")
        if voteStackView.subviews.count == voteTextArray.count {
            print("추가한 필드에 모두 입력이 되어 있음.")
        } else {
            print("모든 필드에 입력이 되어있지 않음.")
        }
    }
    
    /**
     투표 설정 버튼 클릭 함수
     > coder : **sanghyeon**
     */
    @IBAction func didTapOptionButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        switch sender {
        case anonymousButton:
            isAnonymouse.toggle()
        case multipleButton:
            isMultiple.toggle()
        case deadlineButton:
            isDeadline.toggle()
            if isDeadline {
                deadlineLabel.isHidden = false
            } else {
                deadlineLabel.isHidden = true
            }
        default: break
        }
    }
    
    /**
     투표 항목 텍스트필드 제거
     > coder : **sanghyeon**
     */
    func removeVoteTextfield(view: UIView) {
        view.removeFromSuperview()
    }
}
