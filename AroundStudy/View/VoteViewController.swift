//  VoteViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/11.
//  스터디 상세 - 투표 메인 뷰 컨트롤러

import UIKit
import FloatingPanel

class VoteViewController: BaseViewController {
    /// 현재 진행중인 투표 테이블 뷰 리스트
    @IBOutlet weak var tableVote: UITableView?
    
    /**
     * @투표 뷰 컨트롤러 초기하
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewCell()
    }
}

//MARK: - tableViewExtension
extension VoteViewController: tableViewExtension {
    /**
     * @투표 테이블 뷰 셀 초기화
     * @creator : coder3306
     */
    private func initTableViewCell() {
        if let tableVote = tableVote {
            VoteTitleTableViewCell.registerXib(targetView: tableVote)
            VoteTableViewCell.registerXib(targetView: tableVote)
        }
    }
    
    /**
     * @투표 테이블 뷰 섹션 초기화(헤더, 아이템)
     * @creator : coder3306
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /**
     * @투표 테이블 뷰 로우 초기화(섹션1, 아이템 갯수에 따라 초기화 진행)
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 5
    }
    
    /**
     * @투표 테이블 뷰 아이템 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableVote = tableVote else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
            case 0:
                if let cell = VoteTitleTableViewCell.dequeueReusableCell(targetView: tableVote) {
                    cell.didTapAddVote {
                        self.moveSelectVoteView()
                    }
                    return cell
                }
            case 1:
                if let cell = VoteTableViewCell.dequeueReusableCell(targetView: tableVote) {
                    cell.didTapExpandView { result in
                        tableVote.performBatchUpdates {
                            //TODO: 셀 재사용 시, 현재 상태를 저장하는 로직 필요함
                            UIView.animate(withDuration: 0.25) {
                                cell.voteDetailStackView?.alpha = (result ?? false) ? 0.0 : 1.0
                                cell.voteDetailStackView?.isHidden = (result ?? false)
                            } completion: { _ in
                                UIView.animate(withDuration: 0.25) {
                                    self.tableVote?.scrollToRow(at: indexPath, at: .middle, animated: false)
                                }
                            }
                        }
                    }
                    return cell
                }
            default:
                return UITableViewCell()
        }
        return UITableViewCell()
    }
}
//MARK: - Action
extension VoteViewController {
    /**
     * @날짜 선택 화면 이동
     * @creator : coder3306
     */
    private func moveSelectVoteView() {
        let vc = SelectDatePopupViewController(nibName: "SelectDatePopupViewController", bundle: nil)
        floatingPanelController = FloatingPanelController(delegate: self)
        setupFloatingView(vc, targetScrollView: UIScrollView(), position: .full)
    }
}
