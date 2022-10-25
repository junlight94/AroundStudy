//
//  VoteTableViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class VoteTableViewCell: UITableViewCell {
    //******************************************************
    //MARK: - IBOutlet
    //******************************************************
    /// 전체 컨텐츠를 감싸고 있는 뷰
    @IBOutlet weak var voteWrapperView: UIView?
    /// 투표 상세내용 뷰
    @IBOutlet weak var voteDetailStackView: UIStackView?
    /// 프로필 이미지 뷰
    @IBOutlet weak var profileImageView: UIImageView?
    /// 참여 인원 뷰
    @IBOutlet weak var statusBoxView: UIView?
    /// 프로필, 투표선택 사이 라인
    @IBOutlet weak var profileLineView: UIView?
    /// 투표하기 내용 뷰
    @IBOutlet weak var voteContentsStackView: UIStackView?
    
    /// 투표하기 버튼을 선택한 후,
    private var selectHandler: boolClosure?
    //******************************************************
    //MARK: - DUMMY
    //******************************************************
    let testVote1 = VoteDetailItemView()
    let testVote2 = VoteDetailItemView()
    let testVote3 = VoteDetailItemView()
    let testVote4 = VoteDetailItemView()
    
    /**
     * @투표 셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        /// 테스트용
        //FIXME: EXPENSIVE COST LOGIC
        self.testVote1.snp.makeConstraints { make in
            /// 스텍뷰의 높이가 고정이므로, 하나의 뷰만 높이 설정해서 추가
            make.height.equalTo(70)
        }
        self.addArrangedSubviews([self.testVote1, self.testVote2, self.testVote3, self.testVote4])
        initLayout()
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            voteDetailStackView?.addArrangedSubview(view)
        }
    }
    
    /**
     * @투표 셀 레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        self.selectionStyle = .none
        voteWrapperView?.layer.zeplinShadow(color: .black, alpha: 0.12, x: 0, y: 1, blur: 6, spread: 0)
        profileImageView?.layer.setBorderLayout(radius: 20)
        statusBoxView?.layer.setBorderLayout(radius: 8)
        voteContentsStackView?.layer.setBorderLayout(radius: 12)
    }
    
    /**
     * @뷰 확장 버튼 선택
     * @creator : coder3306
     * @Return : 현재 뷰가 확장되었는지를 확인하고, 리턴으로 확장상태를 넘김
     */
    public func didTapExpandView(_ complete: @escaping boolClosure) {
        self.selectHandler = complete
    }
    
    //******************************************************
    //MARK: - Action
    //******************************************************
    /**
     * @투표 내용 상세보기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction func showVoteDetail(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        profileLineView?.isHidden = sender.isSelected
        selectHandler?(sender.isSelected)
    }
}
