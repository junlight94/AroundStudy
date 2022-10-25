//
//  PhotoPicker.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/22.
//

import UIKit

struct PhotoPicker {
    var index: Int
    var data: ImageData
}

struct ImageData {
    var original: UIImage
    var processed: UIImage?
}
