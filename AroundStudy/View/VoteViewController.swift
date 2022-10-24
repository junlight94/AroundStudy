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
    
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 셀 높이 저장
    var cellHeights = [IndexPath: CGFloat]()
    /// DUMMY
    let testcount = 20
    // willDisplay의 노티피케이션 전송 여부
    var isPost: Bool = false
    
    //******************************************************
    //MARK: - ViewController LifeCycle
    //******************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewCell()
        NotificationCenter.default.post(name: NSNotification.Name("viewHeight"), object: 500000)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calcCellHeights()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isPost = false
    }
    
    /**
     * @셀의 높이값 계산
     * @creator : coder3306
     */
    func calcCellHeights() {
        //FIXME: NEED PAGING LOGIC
        self.isPost = true
        NotificationCenter.default.post(name: NSNotification.Name("viewHeight")
                                      , object: self.cellHeights.compactMap({ CGFloat($0.value )}).reduce(0, +))
    }
}

//MARK: - tableViewExtension
extension VoteViewController: tableViewExtension {
    /**
     * @투표 테이블 뷰 셀 초기화
     * @creator : coder3306
     */
    private func initTableViewCell() {
        tableVote?.isScrollEnabled = false
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
        return testcount
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
                    return cell
                }
            case 1:
                if let cell = VoteTableViewCell.dequeueReusableCell(targetView: tableVote) {
                    cell.didTapExpandView { result in
                        DispatchQueue.main.async {
                            tableVote.performBatchUpdates {
                                UIView.animate(withDuration: 0.25) {
                                    cell.voteDetailStackView?.alpha = (result ?? false) ? 0.0 : 1.0
                                    cell.voteDetailStackView?.isHidden = (result ?? false)
                                } completion: { _ in
                                    DispatchQueue.main.async {
                                        self.cellHeights[indexPath] = cell.frame.size.height
                                        self.calcCellHeights()
                                    }
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
    
    /**
     * @셀 높이 암시적 설정
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
    
    /**
     * @현재 셀의 높이를 저장
     * @creator : coder3306
     * @param cell : 인덱스에 맞는 셀 데이터
     * @param indexPath : 셀 인덱스
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            print(indexPath)
            self.cellHeights[indexPath] = cell.frame.size.height
            if self.cellHeights.count == self.testcount + 1, !self.isPost {
                self.calcCellHeights()
            }
        }
    }
}
