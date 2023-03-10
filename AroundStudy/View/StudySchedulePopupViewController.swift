//  StudycalendarViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/05.
//  스터디 상세 중 스케쥴 보기 화면입니다.

import UIKit
import FSCalendar

class StudySchedulePopupViewController: BaseViewController {
    @IBOutlet weak var tablePlan: UITableView?
    
    //******************************************************
    //MARK: - ViewController
    //******************************************************
    /**
     * @스터디 상세보기 뷰 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewCell()
    }
}

//MARK: - tableViewExtension
extension StudySchedulePopupViewController: tableViewExtension {
    /**
     * @테이블뷰 셀 초기화
     * @creator : coder3306
     */
    public func initTableViewCell() {
        if let tablePlan = tablePlan {
            CustomCalendarTableViewCell.registerXib(targetView: tablePlan)
            StudyScheduleTitleTableViewCell.registerXib(targetView: tablePlan)
            ScheduleTableViewCell.registerXib(targetView: tablePlan)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    /**
     * @캘린더 테이블 뷰 갯수 설정
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 {
            return 1
        }
        return 5
    }

    /**
     * @캘린더 셀 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablePlan = tablePlan else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
            case 0:
                if let cell = CustomCalendarTableViewCell.dequeueReusableCell(targetView: tablePlan) {
                    return cell
                }
            case 1:
                if let cell = StudyScheduleTitleTableViewCell.dequeueReusableCell(targetView: tablePlan) {
                    return cell
                }
            case 2:
                if let cell = ScheduleTableViewCell.dequeueReusableCell(targetView: tablePlan) {
                    return cell
                }
            default:
                return UITableViewCell()
        }
        return UITableViewCell()
    }
}
