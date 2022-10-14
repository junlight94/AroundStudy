//
//  String+Extension.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/27.
//

import Foundation

extension String {
    /**
     * @스트링을 문자 데이터로 변환
     * @creator : coder3306
     */
    func stringToDate() -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateformatter.timeZone = TimeZone(identifier: "UTC")
        return dateformatter.date(from: self)
    }
}
