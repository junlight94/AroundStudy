//
//  VoteTableViewCell.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/02.
//

import UIKit

class VoteTableViewCell: UITableViewCell, reusableTableView {

    /// 테스트용 변수, 실 개발시 사용 안하는 변수입니다.
    var isExpended: Bool = true
    
    
    @IBOutlet weak var voteWrapperView: UIView!
    @IBOutlet weak var voteInnerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var voteDetailWrapperView: UIView!
    @IBOutlet weak var voteDetailStackView: UIStackView!
    @IBOutlet weak var voteDetailLineView: UIView!
    @IBOutlet weak var statusBoxView: UIView!
    
    let testVote1 = VoteDetailItemView()
    let testVote2 = VoteDetailItemView()
    let testVote3 = VoteDetailItemView()
    let testVote4 = VoteDetailItemView()
    
    var completeAnimation: boolClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        /// 전체를 감싸는 뷰 그림자
        voteWrapperView.layer.zeplinShadow(color: .black, alpha: 0.12, x: 0, y: 1, blur: 6, spread: 0)
        /// 전체를 감싸는 뷰 코너 라운딩
        voteWrapperView.layer.cornerRadius = 12
        /// 항목들을 감싸는 뷰 코너 라운딩
        voteInnerView.layer.cornerRadius = 12
        /// 프로필 이미지 뷰 코너 라운딩
        profileImageView.layer.cornerRadius = 20
        /// 상태 감싸는 뷰 코너 라운딩
        statusBoxView.layer.cornerRadius = 8
        
        
        testVote1.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        /// 테스트용
        voteDetailStackView.addArrangedSubview(testVote1)
        voteDetailStackView.addArrangedSubview(testVote2)
        voteDetailStackView.addArrangedSubview(testVote3)
        voteDetailStackView.addArrangedSubview(testVote4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func didTapExpandView(_ complete: @escaping boolClosure) {
        self.completeAnimation = complete
    }
    
    @IBAction func didTapVoteButton(_ sender: Any) {
        print("셀에서 투표하기 버튼 눌림")
        //FIXME: - 애니메이션 공통처리 및 레이아웃 업데이트 수정
        isExpended.toggle()
        voteDetailStackView.subviews[0].snp.updateConstraints { make in
            let remakeConstraints = isExpended ? 80 : 0
            UIView.animate(withDuration: 0.3) {
                self.voteDetailStackView.subviews[0].snp.updateConstraints { make in
                    make.height.equalTo(remakeConstraints)
                }
            } completion: { _ in
                self.completeAnimation?(self.isExpended)
            }
        }
    }
}
