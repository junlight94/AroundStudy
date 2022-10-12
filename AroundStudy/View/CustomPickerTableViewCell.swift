//
//  CustomPickerTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/11.
//

import UIKit

class CustomPickerTableViewCell: UITableViewCell, reusableTableView {
    @IBOutlet weak var timePickerView: UIPickerView?
    
    var hour = [String]()
    var minute = [String]()
    
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
    
    private func initLayout() {
        timePickerView?.backgroundColor = .clear
        let upLine = UIView(frame: CGRect(x: 15, y: 0, width: 56, height: 2))
        let underLine = UIView(frame: CGRect(x: 15, y: 60, width: 56, height: 2))
        upLine.backgroundColor = UIColor(named: "naver")
        underLine.backgroundColor = UIColor(named: "naver")
        
        timePickerView?.subviews[0].addSubview(upLine)
        timePickerView?.subviews[0].addSubview(underLine)
        timePickerView?.subviews[1].addSubview(upLine)
        timePickerView?.subviews[1].addSubview(underLine)

    }
}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension CustomPickerTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    /**
     * @커스텀 피커 뷰 선택 가능한 갯수 설정
     * @creator : coder3306
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    /**
     * @커스텀 피커 뷰 데이터 초기화
     * @creator : coder3306
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hour.count
        }
        return minute.count
    }
    
    /**
     * @커스텀 피커 뷰 제목 설정
     * @creator : coder3306
     * @param <# param #> : <# desc #>
     * @param <# param #> : <# desc #>
     * @param <# param #> : <# desc #>
     * @Return : <# desc #>
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return hour[row]
        }
        return minute[row]
    }
    
    /**
     * @시간이 선택되었을 때 해야 할 행동 전달
     * @creator : coder3306
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
}
