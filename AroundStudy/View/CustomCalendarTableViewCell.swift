//  CustomCalendarTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/11.
//

import UIKit
import FSCalendar

class CustomCalendarTableViewCell: UITableViewCell, reusableTableView {
    /// 캘린더 뷰
    @IBOutlet weak var viewcalendar: FSCalendar?
    /// YYYY년 M월 라벨
    @IBOutlet weak var lblDate: UILabel?
    
    /// 현재 날짜 저장
    private var currentDate: Date?
    /// 날짜 포매터 초기화
    /// 지역 > 한국, 형식 > YYYY년 M월
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월"
        return dateFormatter
    }()
    
    var datehandler: dataClosure?
    
    /**
     * @커스텀 캘린더 셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        viewcalendar?.delegate = self
        viewcalendar?.dataSource = self
        setCustomCalendarStyle()
    }
    
    /**
     * @커스텀 캘린더 설정
     * @creator : coder3306
     */
    private func setCustomCalendarStyle() {
        viewcalendar?.locale = Locale(identifier: "ko_KR")
        viewcalendar?.appearance.titleFont = UIFont(name: "Pretendard-Medium", size: 15.0)
        viewcalendar?.appearance.weekdayFont = UIFont(name: "Pretendard-Medium", size: 15.0)
        viewcalendar?.headerHeight = 0
        viewcalendar?.allowsMultipleSelection = true
        if let calendarPage = viewcalendar?.currentPage {
            lblDate?.text = self.dateFormatter.string(from: calendarPage)
        }
    }
    
    /**
     * @캘린더 버튼으로 월 이동
     * @creator : coder3306
     * @param isPrev : 지난달 조회
     */
    private func moveCalederMonth(isPrev: Bool) {
        let current = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        self.currentDate = current.date(byAdding: dateComponents, to: currentDate ?? Date())
        self.viewcalendar?.setCurrentPage(currentDate ?? Date(), animated: true)
    }
    
    public func didSelectDay(_ complete: @escaping dataClosure) {
        self.datehandler = complete
    }
    
    //******************************************************
    //MARK: - Action
    //******************************************************
    /**
     * @캘린더 이전달 이동
     * @creator : coder3306
     */
    @IBAction private func actioncalendarPrev(_ sender: UIButton) {
        moveCalederMonth(isPrev: true)
    }
    
    /**
     * @캘린더 다음달 이동
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actioncalendarNext(_ sender: UIButton) {
        moveCalederMonth(isPrev: false)
    }
}

extension CustomCalendarTableViewCell: FSCalendarDelegate, FSCalendarDataSource {
    /**
     * @캘린더 선택 시 현재 날짜를 콜백해주는 메서드
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //FIXME: 캘린더 두줄작업 및 연결해서 선택하기
        if calendar.selectedDates.count > 2 {
            calendar.deselect(calendar.selectedDates[0])
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: date) + " 선택됨")
        print(calendar.selectedDates.sorted(by: <))
        datehandler?(calendar.selectedDates)
    }
    
    /**
     * @캘린더 페이지 전환 콜백 메서드
     * @creator : coder3306
     */
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let dateComponents = DateComponents()
        self.currentDate = Calendar.current.date(byAdding: dateComponents, to: calendar.currentPage)
        
        self.lblDate?.text = self.dateFormatter.string(from: calendar.currentPage)
    }
    
    /**
     * @날짜 선택 최대 갯수 제한 설정 (2개)
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true
    }
}
