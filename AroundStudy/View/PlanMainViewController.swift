//
//  PlanMainViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/18.
//

import UIKit

class PlanMainViewController: UIViewController {

    @IBOutlet weak var planTableView: UITableView!
    
    /// 테이블뷰 셀 사이즈
    var tableViewRowHeight: CGFloat = 160
    /// 테이블뷰 높이 제약
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        print(getViewHeight())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("viewHeight"), object: getViewHeight(), userInfo: nil)
    }
}

//MARK: - Layout
extension PlanMainViewController {
    /**
     초기 레이아웃 설정
     > coder : **sanghyeon**
     */
    func setupView() {
        /// 테이블뷰 설정
        planTableView.isScrollEnabled = false
        planTableView.rowHeight = tableViewRowHeight
        planTableView.separatorStyle = .none
        planTableView.delegate = self
        planTableView.dataSource = self
        let cellNib = UINib(nibName: "ScheduleDetailTableViewCell", bundle: nil)
        planTableView.register(cellNib, forCellReuseIdentifier: "ScheduleDetailTableViewCell")
    }
    
    /// 캘린더 버튼 클릭
    @IBAction func didTapCalendarButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: .showSchedulePopup, object: nil)
    }
    /// 일정 추가 버튼 클릭
    @IBAction func didTapAddButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("viewController"), object: "addPlan", userInfo: nil)
    }
}

//MARK: - TableView
extension PlanMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(indexPath: indexPath)
    }
    
    /**
     테이블뷰 세팅
     - 기본 테이블뷰 세팅 대체함수
     > coder : **sanghyeon**
     */
    func setupCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = planTableView.dequeueReusableCell(withIdentifier: "ScheduleDetailTableViewCell", for: indexPath) as? ScheduleDetailTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    /**
     뷰컨의 전체 높이 사이즈
     - 옵저버로 넘기기 위한 뷰컨의 전체 높이 사이즈 반환
     - 값을 반환하면서 테이블뷰의 높이도 같이 변경합니다.
     > coder : **sanghyeon**
     */
    func getViewHeight() -> CGFloat {
        let tableViewMinY: CGFloat = planTableView.frame.minY
        let tableViewContentCount: Int = 20
        let totalHeight = tableViewMinY + ( CGFloat(tableViewContentCount) * tableViewRowHeight )
        tableViewHeightConstraint.constant = CGFloat(tableViewContentCount) * tableViewRowHeight
        return totalHeight
    }
}
