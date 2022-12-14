//  CustomPickerTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/11.
//  커스텀 피커 뷰

import UIKit

class CustomPickerTableViewCell: UITableViewCell {
    /// 커스텀 피커 뷰
    @IBOutlet weak var timePickerView: UIPickerView?
    
    /// 생성된 시간 리스트
    private var hour = [String]()
    /// 생성돤 분 리스트
    private var minute = [String]()
    /// 선택한 시간 전달 핸들러
    private var hourHandler: dataClosure?
    /// 선택한 분 전달 핸들러
    private var minuteHandler: dataClosure?
    
    /**
     * @커스텀 피커 뷰 셀 초기화
     * @creator : coder3306
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        timePickerView?.delegate = self
        timePickerView?.dataSource = self
        setTimeData()
    }
    
    /**
     * @레이아웃 정의
     * @creator : coder3306
     */
    override func layoutSubviews() {
        initLayout()
    }
    
    /**
     * @피커 뷰 시간 설정
     * @creator : coder3306
     */
    private func setTimeData() {
        for hour in 0 ..< 24 {
            if hour < 10 {
                self.hour.append("0\(hour)")
            } else {
                self.hour.append("\(hour)")
            }
        }
        for minute in 0 ..< 60 {
            if minute < 10 {
                self.minute.append("0\(minute)")
            } else {
                self.minute.append("\(minute)")
            }
        }
    }
    
    /**
     * @레이아웃 설정
     * @creator : coder3306
     */
    private func initLayout() {
        timePickerView?.subviews.forEach({
            $0.backgroundColor = .clear
        })
        
        let upLine = UIView(frame: CGRect(x: 0, y: 0, width: (self.timePickerView?.bounds.width ?? 197) - 15, height: 2))
        let upDeadLine = UIView(frame: CGRect(x: 56, y: 0, width: 68, height: 2))
        let underLine = UIView(frame: CGRect(x: 0, y: 50, width: (self.timePickerView?.bounds.width ?? 197) - 15, height: 2))
        let underDeadLine = UIView(frame: CGRect(x: 56, y: 50, width: 68, height: 2))
        
        upLine.backgroundColor = UIColor(named: "naver")
        underLine.backgroundColor = UIColor(named: "naver")
        upDeadLine.backgroundColor = .white
        underDeadLine.backgroundColor = .white
        
        timePickerView?.subviews[1].addSubview(upLine)
        timePickerView?.subviews[1].addSubview(upDeadLine)
        timePickerView?.subviews[1].addSubview(underLine)
        timePickerView?.subviews[1].addSubview(underDeadLine)
    }
    
    /**
     * @커스텀 피커 뷰 생성
     * @creator : coder3306
     * @param components : 피커뷰 아이템 위치 설정
     * @param row : 피커뷰 열 갯수
     * @Return : 제작된 뷰 반환
     */
    private func makePickerView(_ component: Int, row: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 56, height: 50))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 56, height: 50))
        if component == 0 {
            label.text = hour[row]
            label.textAlignment = .center
            label.font = UIFont.setCustomFont(.bold, size: 25)
            view.addSubview(label)
            return view
        } else if component == 1 {
            label.text = ":"
            label.textAlignment = .center
            label.font = UIFont.setCustomFont(.bold, size: 25)
            view.addSubview(label)
            return view
        } else if component == 2 {
            label.text = minute[row]
            label.textAlignment = .center
            label.font = UIFont.setCustomFont(.bold, size: 25)
            view.addSubview(label)
            return view
        }
        return view
    }
    
    /**
     * @선택된 시간 데이터 콜백 메서드
     * @creator : coder3306
     * @Return : 선택된 시간을 전달함.
     */
    public func didSelectHour(_ complete: @escaping dataClosure) {
        self.hourHandler = complete
    }
    
    /**
     * @선택된 분 데이터 콜백 메서드
     * @creator : coder3306
     * @Return : 선택된 시간을 전달함.
     */
    public func didSelectMinute(_ complete: @escaping dataClosure) {
        self.minuteHandler = complete
    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension CustomPickerTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    /**
     * @커스텀 피커 뷰 선택 가능한 갯수 설정
     * @creator : coder3306
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    /**
     * @커스텀 피커 뷰 데이터 초기화
     * @creator : coder3306
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hour.count
        } else if component == 1 {
            return 1
        }
        return minute.count
    }
    
    /**
     * @커스텀 피커 뷰 제목 설정
     * @creator : coder3306
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return hour[row]
        } else if component == 1 {
            return ":"
        }
        return minute[row]
    }
    
    /**
     * @커스텀 피커 뷰 데이터 설정
     * @creator : coder3306
     */
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return makePickerView(component, row: row)
    }
    
    /**
     * @시간이 선택되었을 때, 선택된 시간의 정보 전달
     * @creator : coder3306
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("hour --------->>>> \(hour[row])")
            hourHandler?(hour[row])
        } else if component == 2 {
            print("minute --------->>>> \(minute[row])")
            minuteHandler?(minute[row])
        }
    }
    
    /**
     * @커스텀 피커 뷰 높이설정
     * @creator : coder3306
     */
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}
