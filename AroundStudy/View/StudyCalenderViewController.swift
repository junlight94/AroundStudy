//  StudyCalenderViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/05.
//  스터디 상세 중 스케쥴 보기 화면입니다.

import UIKit
import FSCalendar

class StudyCalenderViewController: BaseViewController {
    /// 캘린더 뷰
    @IBOutlet weak var viewCalender: FSCalendar?
    
    /// 캘린더 지난달 이동
    private var calenderPrev: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_prev"), for: .normal)
        button.addTarget(StudyCalenderViewController.self, action: #selector(actionCalenderPrev(_:)), for: .touchUpInside)
        return button
    }()
    /// 캘린더 다음달 이동
    private var calenderNext: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow_next"), for: .normal)
        button.addTarget(StudyCalenderViewController.self, action: #selector(actionCalenderNext(_:)), for: .touchUpInside)
        return button
    }()
    
    /**
     * @스터디 상세보기 뷰 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCalender?.delegate = self
        viewCalender?.dataSource = self
        setCustomCalenderStyle()
    }
    
    /**
     * @커스텀 캘린더 설정
     * @creator : coder3306
     */
    private func setCustomCalenderStyle() {
        viewCalender?.locale = Locale(identifier: "ko_KR")
        viewCalender?.appearance.headerTitleFont = UIFont(name: "Pretendard-Bold", size: 17.0)
        viewCalender?.appearance.titleFont = UIFont(name: "Pretendard-Regular", size: 15.0)
        viewCalender?.appearance.headerDateFormat = "YYYY년 M월"
        viewCalender?.scrollDirection = .vertical
        
        viewCalender?.addSubview(calenderPrev)
        calenderPrev.snp.makeConstraints { make in
            make.topMargin.equalTo(8)
            make.leftMargin.equalTo(16)
        }
        viewCalender?.addSubview(calenderNext)
        calenderNext.snp.makeConstraints { make in
            make.topMargin.equalTo(8)
            make.rightMargin.equalTo(-16)
        }
    }
}

//MARK: - tableViewExtension
extension StudyCalenderViewController: tableViewExtension {
    private func initTableViewCell() {
        //TODO: - 커스텀 xib 등록(여러군데에서 사용할 경우 분기처리해서 등록할수 있게 수정할 것
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}

//MARK: - FSCalendarDelegate, FSCalendarDataSource
extension StudyCalenderViewController: FSCalendarDelegate, FSCalendarDataSource {
    @objc private func actionCalenderPrev(_ sender: UIButton ) {
        
    }
    
    @objc private func actionCalenderNext(_ sender: UIButton ) {
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: date) + " 선택됨")
    }
}
