//
//  OpenStudySelectTimeViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/15.
//

import UIKit

class OpenStudySelectTimeViewController: BaseViewController {
    /// 시간 선택 테이블 뷰
    @IBOutlet weak var tableTime: UITableView?
    /// 선택 완료 버튼
    @IBOutlet weak var btnComplete: UIButton?
    
    /// 선택한 시간
    private var selectedHour: String = "00"
    /// 선택한 분
    private var selectedMinute: String = "00"
    /// 선택한 시간 + 분을 전달할 클로저
    private var selectedTime: dataClosure?
    
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
        tableTime?.layer.setBorderLayout(radius: 40, width: 0, color: nil)
        tableTime?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tableTime?.isScrollEnabled = false
        btnComplete?.layer.setBorderLayout(radius: 8)
    }
    
    /**
     * @선택한 시간 콜백 처리
     * @creator : coder3306
     * @Return : 선택한 시간 정보를 콜백 메서드로 전달(HH:mm)
     */
    public func selectedTimeHandler(_ complete: @escaping dataClosure) {
        self.selectedTime = complete
    }
    
    /**
     * @선택한 시간 반환
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionSelectTime(_ sender: UIButton) {
        selectedTime?("\(selectedHour):\(selectedMinute)")
        self.dismiss(animated: true)
    }
    
    /**
     * @화면 종료
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func actionClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension OpenStudySelectTimeViewController: tableViewExtension {
    /**
     * @테이블뷰 초기화
     * @creator : coder3306
     */
    private func initTableViewCell() {
        if let tableTime = tableTime {
            CustomPickerTableViewCell.registerXib(targetView: tableTime)
        }
    }
    
    /**
     * @테이블뷰 로우 설정
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /**
     * @테이블뷰 셀 설정
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableTime = tableTime else {
            return UITableViewCell()
        }
        if let cell = CustomPickerTableViewCell.dequeueReusableCell(targetView: tableTime) {
            cell.didSelectHour { [weak self] hour in
                if let hour = hour as? String {
                    self?.selectedHour = hour
                }
            }
            cell.didSelectMinute { [weak self] minute in
                if let minute = minute as? String {
                    self?.selectedMinute = minute
                }
            }
            return cell
        }
        return UITableViewCell()
    }
}
