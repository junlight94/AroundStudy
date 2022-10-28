//
//  UIImage+Extension.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/21.
//

import UIKit
import Kingfisher

extension UIImage {
    /// 네비게이션바 백버튼 이미지
    @nonobjc class var navigationBack: UIImage {
        return UIImage(named: "back")!
    }
}

extension UIImageView {
    /**
     * @Kingfisher 이용 이미지 다운로드
     * @creator : coder3306
     * @param imageURL : 다운로드 할 이미지 주소
     */
    func setImage(imageURL: String) {
        let cache = ImageCache.default
        self.kf.indicatorType = .activity
        cache.retrieveImage(forKey: imageURL, options: nil) { result in
            switch result {
                case .success(let value):
                    if let image = value.image {
                        self.image = image
                    } else {
                        guard let url = URL(string: imageURL) else { return }
                        let resource = ImageResource(downloadURL: url, cacheKey: imageURL)
                        self.kf.setImage(with: resource)
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
