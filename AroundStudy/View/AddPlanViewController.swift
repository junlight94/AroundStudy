//
//  AddPlanViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/13.
//

import UIKit

class AddPlanViewController: BaseViewController {
    
    /// 수정 모드 여부 프로퍼티
    var isEditMode: Bool = false
    /// 컬러피커 컬러셋
    var pickerColorSet: [UIColor] = [
        .init(named: "pickerGreen")!,
        .init(named: "pickerOrange")!,
        .init(named: "pickerRed")!,
        .init(named: "pickerSkyBlue")!,
        .init(named: "pickerBlue")!,
        .init(named: "pickerPurple")!
    ]
    var selectedColorIndex: Int = 0
    /// 멤버 컬렉션뷰 높이 제약
    @IBOutlet weak var memberCollectionViewHeightConstraint: NSLayoutConstraint!
    
    
    /// 백버튼
    let backButton = UIButton(type: .custom)
    /// 오른쪽 완료 버튼
    let completeButton = UIButton(type: .system)
    /// 일정 타이틀 라벨
    @IBOutlet weak var planTitleTextFieldView: AddVoteTextfieldView!
    /// 일정 설명 텍스트뷰
    @IBOutlet weak var planDescTextView: UITextView!
    /// 일정 대표 색상 셀렉트 컬렉션뷰
    @IBOutlet weak var colorPickerCollectionView: UICollectionView!
    /// 참여 인원 컬렉션뷰
    @IBOutlet weak var memberCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

extension AddPlanViewController {
    /**
     초기 레이아웃 설정
     > coder : **sanghyeon**
     */
    func setupView() {
        /// 네비게이션바 세팅
        /// 네비게이션바 버튼 설정
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.tintColor = UIColor(named: "40")
        completeButton.setTitle(isEditMode ? "수정완료" : "등록하기", for: .normal)
        completeButton.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 15)
        completeButton.tintColor = UIColor(named: "94")
        setNavigationBar(isEditMode ? "일정 수정" : "새 일정 등록", leftBarButton: [backButton], rightBarButton: [completeButton], isLeftSetting: true)
        
        /// 컬러 피커 컬렉션뷰 설정
        let colorPickerCellNib = UINib(nibName: "ColorSetCollectionViewCell", bundle: nil)
        colorPickerCollectionView.register(colorPickerCellNib, forCellWithReuseIdentifier: "ColorSetCollectionViewCell")
        colorPickerCollectionView.delegate = self
        colorPickerCollectionView.dataSource = self
        
        /// 참여인원 컬렉션뷰 설정
        let memberProfileCellNib = UINib(nibName: "MemberProfileCollectionViewCell", bundle: nil)
        memberCollectionView.register(memberProfileCellNib, forCellWithReuseIdentifier: "MemberProfileCollectionViewCell")
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        
        /// 일정 설명 텍스트뷰 설정
        planDescTextView.delegate = self
    }
}

//MARK: - 컬렉션뷰
extension AddPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case colorPickerCollectionView:
            return 6
        case memberCollectionView:
            return 23
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return setupCell(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCollectionViewCell(collectionView, indexPath: indexPath)
    }
    
    /**
     컬렉션뷰 셀 설정 (기본함수) 대체
     > coder : **sanghyeon**
     */
    func setupCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case colorPickerCollectionView:
            guard let cell = colorPickerCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorSetCollectionViewCell", for: indexPath) as? ColorSetCollectionViewCell else { return UICollectionViewCell() }
            cell.setInitCell(color: pickerColorSet[indexPath.row])
            if indexPath.row == selectedColorIndex {
                cell.selectCell()
            }
            return cell
        case memberCollectionView:
            guard let cell = memberCollectionView.dequeueReusableCell(withReuseIdentifier: "MemberProfileCollectionViewCell", for: indexPath) as? MemberProfileCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    /**
     컬렉션뷰 셀 선택 (기본함수) 대체
     > coder : **sanghyeon**
     */
    func selectCollectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) {
        switch collectionView {
        case colorPickerCollectionView:
            selectedColorIndex = indexPath.row
            colorPickerCollectionView.reloadData()
            
        default: break
        }
    }
    
    /// 컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case colorPickerCollectionView:
            return .init(width: 32, height: 32)
        case memberCollectionView:
            guard let cell = memberCollectionView.dequeueReusableCell(withReuseIdentifier: "MemberProfileCollectionViewCell", for: IndexPath(row: 0, section: 0)) as? MemberProfileCollectionViewCell else { return .zero }
            let cellHeight = cell.getCellSize()
            /// 컬렉션뷰 사이즈 조정
            let viewWidth = self.view.frame.width
            let validViewWidth = viewWidth - 40 + 21
            let validSingleLineCell = floor(validViewWidth / 71)
            // FIXME: - 추후 데이터 연동시 전체 아이템 개수를 통해 계산해야함
            let collectionViewRowCount = ceil(23 / validSingleLineCell)
            let collectionViewHeight = ((cellHeight + 24) * collectionViewRowCount) - 24
            memberCollectionViewHeightConstraint.constant = collectionViewHeight
            return .init(width: 50, height: cellHeight)
        default: return .zero
        }
    }
    
}

//MARK: - 텍스트뷰
extension AddPlanViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = planTitleTextFieldView.textfield.textColor
        textView.text = nil
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "일정에 대한 설명을 입력해주세요."
            textView.textColor = .placeholderText
        }
    }
}
