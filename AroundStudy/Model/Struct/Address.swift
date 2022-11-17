//
//  Address.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/16.
//

import Foundation

struct Documents: Codable {
    var documents: [Address]
}

struct Address: Codable {
    let addressName: String
    let xPos: String
    let yPos: String
    
    enum CodingKeys: String, CodingKey {
        case addressName = "address_name"
        case xPos = "x"
        case yPos = "y"
    }
}
