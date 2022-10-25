//  CustomCalendarTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/11.
//

import UIKit
import FSCalendar

class CustomCalendarTableViewCell: UITableViewCell {
    //******************************************************
    //MARK: - IBOutlet
    //******************************************************
    /// 캘린더 뷰
    @IBOutlet weak var calendar: FSCalendar?
    /// YYYY년 M월 라벨
    @IBOutlet weak var lblDate: UILabel?
    
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 날짜 포매터 초기화
    /// 지역 > 한국, 형식 > YYYY년 M월
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy년 M월"
        return dateFormatter
    }()
    private lazy var currentPage = calendar?.currentPage
    /// 그래고리안 달력
    private let gregorian = Calendar(identifier: .gregorian)
    /// 시작일
    private var startDate: Date?
    /// 종료일
    private var endDate: Date?
    /// 선택된 날짜 리스트
    private var selectedDates: [Date]?
    /// 선택된 날짜를 전달해주는 핸들러
    private var datehandler: dataClosure?
    /// 이벤트가 있는 날짜 리스트
    public var eventDates: [Date]?
    
    //******************************************************
    //MARK: - ViewController
    //******************************************************
    /**
     * @커스텀 캘린더 셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        calendar?.delegate = self
        calendar?.dataSource = self
        setCustomCalendarStyle()
        
        //******************************************************
        //MARK: - 이벤트가 있는 날짜 테스트 용 더미데이터
        //******************************************************
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let test1 = formatter.date(from: "2022-10-15")
        let test2 = formatter.date(from: "2022-10-15")
        let test3 = formatter.date(from: "2022-10-16")
        eventDates = [test1!,test2!,test3!]
    }
    
    /**
     * @커스텀 캘린더 설정
     * @creator : coder3306
     */
    private func setCustomCalendarStyle() {
        calendar?.locale = Locale(identifier: "ko_KR")
        calendar?.appearance.titleFont = UIFont.setCustomFont(.medium, size: 15.0)
        calendar?.appearance.weekdayFont = UIFont.setCustomFont(.medium, size: 15.0)
        calendar?.headerHeight = 0
        calendar?.allowsMultipleSelection = true
        calendar?.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        calendar?.today = nil
        let currentMonth = dateFormatter.string(from: Date())
        lblDate?.text = currentMonth
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
        self.currentPage = current.date(byAdding: dateComponents, to: currentPage ?? Date())
        self.calendar?.setCurrentPage(currentPage ?? Date(), animated: true)
        lblDate?.text = dateFormatter.string(from: currentPage ?? Date())
    }
    
    /**
     * @선택된 날짜 전달
     * @creator : coder3306
     * @Return : 핸들러로 지금 선택된 날짜를 전달함.
     */
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

//MARK : - FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance
extension CustomCalendarTableViewCell: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    /**
     * @커스텀 캘린더 셀 설정
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    /**
     * @커스텀 캘린더 셀을 그리기 전 설정
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    /**
     * @날짜 선택 후처리
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    /**
     * @날짜 선택 취소 후처리
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    /**
     * @날짜가 선택되었을 때, 레이아웃 및 데이터 전달 설정
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if startDate == nil {
            startDate = date
            selectedDates = [date]
            self.configureVisibleCells()
            datehandler?(nil)
        } else if let start = startDate, endDate == nil {
            if date <= start {
                calendar.deselect(start)
                startDate = date
                selectedDates = [start]
                self.configureVisibleCells()
                return
            }
            let selectedRange = selectedDates(from: start, to: date)
            endDate = selectedRange.last
            _ = selectedRange.map({ date in
                calendar.select(date)
            })
            selectedDates = selectedRange
            datehandler?(selectedDates)
            self.configureVisibleCells()
        } else if startDate != nil && endDate != nil {
            _ = calendar.selectedDates.map({ date in
                calendar.deselect(date)
            })
            endDate = nil
            startDate = nil
            selectedDates = []
            datehandler?(nil)
            self.configureVisibleCells()
        }
    }

    /**
     * @캘린더 페이지 전환 후처리
     * @creator : coder3306
     */
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.currentPage = calendar.currentPage
        //FIXME: - 날짜가 9월30일로 고정되는 이슈, 시뮬레이터에서만 그런건지 확인 필요함.
        print(self.currentPage)
        self.lblDate?.text = self.dateFormatter.string(from: currentPage ?? Date())
    }
    
    /**
     * @날짜 선택 해제 후처리
     * @creator : coder3306
     * @param date : 선택해제된 날짜
     */
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        _ = calendar.selectedDates.map({ date in
            calendar.deselect(date)
        })
        endDate = nil
        startDate = nil
        selectedDates = []
        datehandler?(nil)
        configureVisibleCells()
    }

    /**
     * @선택한 날짜 후처리
     * @creator : coder3306
     * @param from : 시작일
     * @param to : 종료일
     * @Return : 후처리된 날짜 리턴
     */
    private func selectedDates(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            if let date = Calendar.current.date(byAdding: .day, value: 1, to: tempDate) {
                tempDate = date
                array.append(tempDate)
            }
        }
        return array
    }
    
    /**
     * @캘린더 셀 데이터 설정
     * @creator : coder3306
     */
    private func configureVisibleCells() {
        calendar?.visibleCells().forEach { (cell) in
            if let date = calendar?.date(for: cell), let position = calendar?.monthPosition(for: cell) {
                self.configure(cell: cell, for: date, at: position)
            }
        }
    }
    
    /**
     * @선택한 셀 레이아웃 처리
     * @creator : coder3306
     * @param cell : 커스텀 캘린더 셀 파싱 데이터
     * @param date : 선택한 날짜
     */
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        guard let customCell = cell as? CalendarCell else { return }
        if position == .current {
            var selectionType = SelectionType.none
            if calendar?.selectedDates.contains(date) == true {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar?.selectedDates.contains(date) == true {
                    if calendar?.selectedDates.contains(previousDate) == true && calendar?.selectedDates.contains(nextDate) == true {
                        selectionType = .middle
                    }
                    else if calendar?.selectedDates.contains(previousDate) == true && calendar?.selectedDates.contains(date) == true {
                        selectionType = .rightBorder
                    }
                    else if calendar?.selectedDates.contains(nextDate) == true {
                        selectionType = .leftBorder
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            customCell.selectionType = selectionType
        } else {
            customCell.selectionType = .none
        }
    }
    
    /**
     * @캘린더 이벤트 처리
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.eventDates?.contains(date) == true {
            if let items = self.eventDates?.filter({ $0 == date }) {
                //TODO: 색상별로 아이템 찍는 상태 변경해주기.
                return items.count
            }
        }
        return 0
    }
}
