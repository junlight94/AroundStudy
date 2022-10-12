//  VoteTitleTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/11.
//  투표 현황 타이틀 테이블 뷰 셀

import UIKit

class VoteTitleTableViewCell: UITableViewCell, reusablebleTableView {
    /// 투표 리스트 정렬 뷰
    @IBOutlet weak var viewSorting: UIView?
    /// 투표 추가하기
    @IBOutlet weak var btnAddVote: UIButton?
    /// 투표 리스트 정렬하기
    @IBOutlet weak var btnSorting: UIButton?
    
    /**
     * @투표 현황 타이틀 셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSorting?.layer.setBorderLayout(radius: 8, width: 1, color:  UIColor(named: "236"))
    }
    
    /**
     * @투표 추가하기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction func actionAddVote(_ sender: UIButton) {
    }
    
    /**
     * @투표 현황 정렬하기
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction func actionSortVote(_ sender: UIButton) {
    }
}
