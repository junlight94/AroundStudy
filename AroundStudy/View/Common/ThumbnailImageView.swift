//
//  ThumbnailImageView.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/30.
//

import UIKit
import SnapKit
import Alamofire

class ThumbnailImageView: UIView {

    let imageView = UIImageView()
    let categoryTitleLabel = UILabel()
    let categoryWrapView = UIView()
    
    /**
     카테고리 타이틀 지정
     > 카테고리 값이 비어있거나, nil일 경우 감싸는 뷰와 라벨을 뷰에서 제거합니다.
     */
    var categoryTitle: String? {
        willSet {
            if let newValue = newValue, newValue != "" {
                categoryTitleLabel.text = newValue
            } else {
                categoryTitleLabel.removeFromSuperview()
                categoryWrapView.removeFromSuperview()
            }
        }
    }
    
    /**
     썸네일의 이미지 입니다.
     >빈 값일 경우 회색의 색깔만 표시합니다.
     */
    var image: String? = "" {
        willSet {
            if let newValue = newValue, newValue != "" {
                let url = URL(string: newValue)!
                //if let data = try? Data(contentsOf: url) {
                    
                //}
                AF.request(newValue, method: .get).responseData { (response) in
                    switch response.result {
                    case .success(let data):
                        self.imageView.image = UIImage(data: data)
                    case .failure(_):
                        self.imageView.backgroundColor = .systemGray6
                    }
                }
            } else {
                imageView.backgroundColor = .systemGray6
            }
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupView()
    }
    
}

extension ThumbnailImageView {
    /**
     * @ 초기 레이아웃 설정
     * coder : sanghyeon
     */
    func setupView() {
        //MARK: ViewPropertyManual
        /// 슈퍼뷰 속성
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        
        /// 썸네일 이미지뷰 속성
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        
        /// 카테고리 타이틀 라벨
        categoryTitleLabel.sizeToFit()
        categoryTitleLabel.font = .init(name: "Pretendard-Medium", size: 12)
        categoryTitleLabel.textColor = .white
        
        /// 카테고리 타이틀 박스
        categoryWrapView.backgroundColor = .black.withAlphaComponent(0.5)
        categoryWrapView.layer.cornerRadius = 4
        
        
        //MARK: AddSubView
        addSubview(imageView)
        addSubview(categoryWrapView)
        addSubview(categoryTitleLabel)
        
        
        //MARK: ViewContraints
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        categoryWrapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(10)
        }
        categoryTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(categoryWrapView).inset(6)
            make.top.bottom.equalTo(categoryWrapView).inset(3)
            
        }
        
        
        //MARK: ViewAddTarget
        
        
        //MARK: Delegate
    }
}
