//  SelectDatePopupViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/12.
//  날짜 선택 팝업 뷰 컨트롤러

import UIKit

class SelectDatePopupViewController: BaseViewController {
    /// 날짜 선택 테이블 뷰
    @IBOutlet weak var tableSelectDate: UITableView?
    /// 날짜 선택 완료
    @IBOutlet weak var btnComplete: UIButton?
    /// 선택한 날짜 정보 뷰
    @IBOutlet weak var selectInfoView: UIView?
    /// 선택한 날짜 정보 뷰 높이
    @IBOutlet weak var selectInfoHeight: NSLayoutConstraint?
    /// 선택한 날짜 라벨
    @IBOutlet weak var lblSelectDateInfo: UILabel?
    
    /// 투표 마감기한 설정 여부
    var isDeadLine: Bool = false
    
    /**
     * @테이블 뷰 셀 식별자 초기화
     * @creator : coder3306
     */
    var cells = [
        CustomCalendarTableViewCell.self
        , CustomPickerTableViewCell.self
    ]
    
    /**
     * @날짜선택 뷰 컨트롤러 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewCell()
        initLayout()
    }
    
    /**
     * @레이아웃 설정
     * @creator : coder3306
     */
    private func initLayout() {
        let infoHeight = isDeadLine ? 0 : 80
        selectInfoView?.isHidden = isDeadLine ? true : false
        selectInfoHeight?.constant = CGFloat(infoHeight)
        if !isDeadLine {
            cells.insert(SelectStartEndSegmentTableViewCell.self, at: 0)
            self.tableSelectDate?.reloadData()
        }
        btnComplete?.layer.setBorderLayout(radius: 8, width: 0, color: nil)
    }
}

//MARK: - tableViewExtension
extension SelectDatePopupViewController: tableViewExtension {
    /**
     * @테이블 뷰 셀 초기화
     * @creator : coder3306
     */
    private func initTableViewCell() {
        if let tableSelectDate = tableSelectDate {
            SelectStartEndSegmentTableViewCell.registerXib(targetView: tableSelectDate)
            CustomCalendarTableViewCell.registerXib(targetView: tableSelectDate)
            CustomPickerTableViewCell.registerXib(targetView: tableSelectDate)
        }
    }
    
    /**
     * @테이블 뷰 로우 설정
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    /**
     * @테이블 뷰 데이터 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableSelectDate = tableSelectDate else {
            return UITableViewCell()
        }
        let cell = cells[indexPath.row]
        if cell == SelectStartEndSegmentTableViewCell.self {
            if let itemCell = SelectStartEndSegmentTableViewCell.dequeueReusableCell(targetView: tableSelectDate) {
                return itemCell
            }
        } else if cell == CustomCalendarTableViewCell.self {
            if let itemCell = CustomCalendarTableViewCell.dequeueReusableCell(targetView: tableSelectDate) {
                itemCell.didSelectDay { [weak self] result in
                    if let result = result as? [Date] {
                        self?.setDayInfo(result)
                    }
                }
                return itemCell
            }
        } else if cell == CustomPickerTableViewCell.self {
            if let itemCell = CustomPickerTableViewCell.dequeueReusableCell(targetView: tableSelectDate) {
                return itemCell
            }
        }
        return UITableViewCell()
    }
}

//MARK: - Action
extension SelectDatePopupViewController {
    /**
     * @선택한 날짜 정보 설정
     * @creator : coder3306
     * @param date : 선택한 날짜 정보 보내기
     */
    private func setDayInfo(_ date: [Date]) {
        //FIXME: 데이터 설정 제대로 안됨. 고칠것
        //FIXME: 날짜 선택 2개 안되면 라벨 히든시키기
        
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "yyyy.MM.DD"
//        let sortDate = date.sorted(by: <)
//        if date.count >= 2 {
//            lblSelectDateInfo?.text = "\(formatter.string(from: sortDate[0])) ~ \(formatter.string(from: sortDate[1]))"
//        } else {
//            lblSelectDateInfo?.text = "\(formatter.string(from: Date())) ~ \(formatter.string(from: sortDate[0]))"
//        }
    }
}
