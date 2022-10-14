//  SelectDatePopupViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/12.
//  날짜 선택 팝업 뷰 컨트롤러

import UIKit

class SelectDatePopupViewController: BaseViewController {
    //******************************************************
    //MARK: - IBOutlet
    //******************************************************
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
    /// 플로팅 패널 뷰
    @IBOutlet weak var floatingView: UIView?
    /// 플로팅 인디케이터 뷰
    @IBOutlet weak var indicatorView: UIView?
    
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 투표 마감기한 설정 여부
    public var isDeadLine: Bool = false
    /// 시작일 / 종료일 구분
    private var isStartDate: Bool?
    /// 시작일 시간
    private var startHour = "00"
    /// 시작일 분
    private var startMinute = "00"
    /// 시작일 시간
    private var endHour = "00"
    /// 시작일 분
    private var endMinute = "00"
    /// 선택한 날짜
    private var selectedDates = [Date]()
    
    //******************************************************
    //MARK: - ViewController
    //******************************************************
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
        floatingView?.layer.setBorderLayout(radius: 40, width: 0, color: nil)
        floatingView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        indicatorView?.layer.setBorderLayout(radius: 3, width: 0, color: nil)
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
                // 시작일/종료일 선택 후처리
                itemCell.didSelectSegmentControl { [weak self] isStartDate in
                    self?.isStartDate = isStartDate
                    if let pickerIndex = self?.cells.lastIndex(where: {$0 == CustomPickerTableViewCell.self}) {
                        self?.tableSelectDate?.reloadRows(at: [IndexPath(row: pickerIndex, section: 0)], with: .none)
                    }
                }
                return itemCell
            }
        } else if cell == CustomCalendarTableViewCell.self {
            if let itemCell = CustomCalendarTableViewCell.dequeueReusableCell(targetView: tableSelectDate) {
                // 날짜 선택 후처리
                itemCell.didSelectDay { [weak self] result in
                    if let result = result as? [Date] {
                        self?.selectedDates = result
                        self!.setDayInfo(self!.selectedDates)
                    } else {
                        self?.lblSelectDateInfo?.text = "날짜를 선택해 주세요."
                        self?.selectedDates = []
                    }
                }
                return itemCell
            }
        } else if cell == CustomPickerTableViewCell.self {
            if let itemCell = CustomPickerTableViewCell.dequeueReusableCell(targetView: tableSelectDate) {
                // 시간 선택 후처리
                itemCell.didSelectHour { [weak self] hour in
                    if let hour = hour as? String {
                        if self?.isStartDate ?? true {
                            self?.startHour = hour
                        } else {
                            self?.endHour = hour
                        }
                        self?.setDayInfo(self!.selectedDates)
                    }
                }
                // 분 선택 후처리
                itemCell.didSelectMinute { [weak self] minute in
                    if let minute = minute as? String {
                        if self?.isStartDate ?? true {
                            self?.startMinute = minute
                        } else {
                            self?.endMinute = minute
                        }
                        self?.setDayInfo(self!.selectedDates)
                    }
                }
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd(EEEEEE)"
        if let startDate = date.first, let endDate = date.last {
            let startInfo = dateFormatter.string(from: startDate)
            let endInfo = dateFormatter.string(from: endDate)
            lblSelectDateInfo?.text = "\(startInfo) \(startHour):\(startMinute) ~ \(endInfo) \(endHour):\(endMinute)"
        }
    }
    
    /**
     * @선택된 날짜 등록 처리
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func selectionComplete(_ sender: UIButton) {
        if selectedDates.isEmpty {
            print("날짜선택 알림팝업 또는 버튼 비활성화 작업 필요")
            return
        }
        if let startDate = selectedDates.first, let endDate = selectedDates.last {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let startInfo = "\(dateFormatter.string(from: startDate)) \(startHour):\(startMinute)"
            let startFormatting = startInfo.stringToDate()
            
            if isDeadLine {
                print(startFormatting ?? "")
            } else {
                let endInfo = "\(dateFormatter.string(from: endDate)) \(endHour):\(endMinute)"
                let endFormatting = endInfo.stringToDate()
                print(startFormatting ?? "")
                print(endFormatting ?? "")
            }
        }
    }
}
