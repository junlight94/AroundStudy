//
//  PlanMainView.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/12.
//

import UIKit

class PlanMainView: UIView {

    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        let titleView: UIView = {
            let titleView = UIView()
            return titleView
        }()
        let titleLabel: UILabel = {
            let titleLabel = UILabel()
            titleLabel.text = "스터디 일정"
            titleLabel.font = UIFont(name: "Pretendard-Bold", size: 18)
            titleLabel.textColor = UIColor(named: "40")
            return titleLabel
        }()
        let buttonStackView: UIStackView = {
            let buttonStackView = UIStackView()
            buttonStackView.axis = .horizontal
            buttonStackView.distribution = .fill
            buttonStackView.spacing = 16
            return buttonStackView
        }()
        let calendarButton: UIButton = {
            let calendarButton = UIButton(type: .custom)
            calendarButton.setImage(UIImage(named: "schedule")?.withRenderingMode(.alwaysTemplate), for: .normal)
            calendarButton.tintColor = UIColor(named: "40")
            return calendarButton
        }()
        let addButton: UIButton = {
            let addButton = UIButton(type: .custom)
            addButton.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
            addButton.tintColor = UIColor(named: "40")
            return addButton
        }()
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(buttonStackView)
        titleView.addSubview(tableView)
        buttonStackView.addArrangedSubview(calendarButton)
        buttonStackView.addArrangedSubview(addButton)
        addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(61)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleView)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(buttonStackView.snp.leading).offset(-10)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.trailing.equalTo(titleView).offset(-20)
            make.centerY.equalTo(titleView)
            make.height.equalTo(24)
        }
        
        calendarButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        tableView.rowHeight = 170
        tableView.isScrollEnabled = true

        
        let tableViewCell = UINib(nibName: "ScheduleDetailTableViewCell", bundle: nil)
        tableView.register(tableViewCell, forCellReuseIdentifier: "ScheduleDetailTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension PlanMainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleDetailTableViewCell", for: indexPath) as? ScheduleDetailTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
