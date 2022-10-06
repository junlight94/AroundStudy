//  StudycalendarViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/05.
//  스터디 상세 중 스케쥴 보기 화면입니다.

import UIKit
import FSCalendar

class CalendarPopupViewController: BaseViewController {
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
    
    //******************************************************
    //MARK: - ViewController
    //******************************************************
    /**
     * @스터디 상세보기 뷰 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        viewcalendar?.delegate = self
        viewcalendar?.dataSource = self
        setCustomcalendarStyle()
    }
    
    /**
     * @커스텀 캘린더 설정
     * @creator : coder3306
     */
    private func setCustomcalendarStyle() {
        viewcalendar?.locale = Locale(identifier: "ko_KR")
        viewcalendar?.appearance.titleFont = UIFont(name: "Pretendard-Regular", size: 15.0)
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
    
    //******************************************************
    //MARK: - IBAction
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

//MARK: - tableViewExtension
extension CalendarPopupViewController: tableViewExtension {
    /**
     * @테이블뷰 셀 초기화
     * @creator : coder3306
     */
    private func initTableViewCell() {
        //TODO: - 커스텀 xib 등록(여러군데에서 사용할 경우 분기처리해서 등록할수 있게 수정할 것
    }
    
    /**
     * @캘린더 테이블 뷰 갯수 설정
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    /**
     * @캘린더 셀 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}

//MARK: - FSCalendarDelegate, FSCalendarDataSource
extension CalendarPopupViewController: FSCalendarDelegate, FSCalendarDataSource {
    /**
     * @캘린더 선택 시 현재 날짜를 콜백해주는 메서드
     * @creator : coder3306
     */
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: date) + " 선택됨")
        print(calendar.selectedDates.sorted(by: <))
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
        if calendar.selectedDates.count > 1 {
            calendar.deselect(calendar.selectedDates[0])
        }
        return true
    }
}
