//
//  CustomPickerTableViewCell.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/11.
//

import UIKit

class CustomPickerTableViewCell: UITableViewCell, reusablebleTableView {
    @IBOutlet weak var timePickerView: UIPickerView?
    
    var hour = [String]()
    var minute = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timePickerView?.delegate = self
        timePickerView?.dataSource = self
        setTimeData()
    }
    
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

extension CustomPickerTableViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return hour.count
        }
        return minute.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return hour[row]
        }
        return minute[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }
}
