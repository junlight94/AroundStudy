//  SelectVoteSegmentTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/12.
//

import UIKit
class SelectStartEndSegmentTableViewCell: UITableViewCell {
    /// 시작일/종료일 선택 세그먼트 컨트롤
    @IBOutlet weak var startEndSegments: CustomSegmentControl?
    
    /// 선택된 세그먼트 상태
    private var selectedSegments: boolClosure?
    
    /**
     * @세그먼트 컨트롤 셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        startEndSegments?.addTarget(self, action: #selector(setTargetControl(_:)), for: .valueChanged)
    }
    
    /**
     * @세그먼트 컨트롤 선택 후처리
     * @creator : coder3306
     * @Return : 시작일, 종료일에 따른 선택된 날짜를 클로저로 넘김
     */
    public func didSelectSegmentControl(_ complete: @escaping boolClosure) {
        self.selectedSegments = complete
    }
    
    /**
     * @세그먼트 컨트롤 타겟 설정
     * @creator : coder3306
     */
    @objc private func setTargetControl(_ sender: UISegmentedControl) {
        if startEndSegments?.selectedSegmentIndex == 0 {
            selectedSegments?(true)
            return
        }
        selectedSegments?(false)
    }
}

