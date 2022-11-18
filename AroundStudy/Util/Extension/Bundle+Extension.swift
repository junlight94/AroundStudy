//
//  Bundle+Extension.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/17.
//

import Foundation

extension Bundle {
    static let keyName = "AroundStudyKey"
    
    var KAKAO_RESTAPI_KEY: String {
        guard let file = self.path(forResource: Bundle.keyName, ofType: "plist") else { return "" }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["KAKAO_RESTAPI_KEY"] as? String else {
            fatalError("API KEY MISSMACHING")
        }
        return key
    }
}
