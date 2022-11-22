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
    /// 투표가 없을 시 노출하는 뷰
    @IBOutlet weak var voteEmptyView: UIView?
    /// 투표 추가하기 버튼
    @IBOutlet weak var btnAddVote: UIButton?
    
    /// 투표하기 버튼 선택 핸들러
    private var selectHandler: boolClosure?
    /// 투표 올리기 요청 핸들러
    private var addVoteHandler: voidClosure?
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
        initLayout()
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
        btnAddVote?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
    }
    
    /**
     * @투표 데이터 설정
     * @creator : coder3306
     */
    public func setData(_ haveItems: Bool) {
        DispatchQueue.main.async {
            self.voteEmptyView?.isHidden = haveItems
            self.voteWrapperView?.isHidden = !haveItems
        }
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
    
    /**
     * @투표 추가하기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionAddVote(_ sender: UIButton) {
        NotificationCenter.default.post(name: .showAddVoteView, object: nil)
    }
}
