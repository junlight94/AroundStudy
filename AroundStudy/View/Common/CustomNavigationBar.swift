//  CustomNavigationBar.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/09/29.
//  커스텀 네비게이션 바 설정
import UIKit
import SnapKit

class CustomNavigationBar: UIView {
    //******************************************************
    //MARK: - Properties
    //******************************************************
    /// 네비게이션 바 컨테이너 뷰
    let containerView = UIView()
    /// 네비게이션 바 타이틀
    let navigationTitleLabel = UILabel()
    /// 네비게이션 바 높이 설정
    var navigationBarHeight: Int = 60 {
        willSet {
            self.containerView.snp.updateConstraints { make in
                if newValue != navigationBarHeight {
                    make.height.equalTo(navigationBarHeight)
                }
            }
        }
    }
    /// 네비게이션 바 타이틀 히든 설정
    var isVisibleTitleLabel: Bool = true {
        willSet {
            navigationTitleLabel.isHidden = isVisibleTitleLabel
        }
    }
    /// 네비게이션 바 쉐도우 설정
    var isDrawShadow: Bool = false {
        willSet {
            if newValue {
                //Rect 계산 필요함
                self.layer.setShadow()
            } else {
                self.layer.removeShadow()
            }
        }
    }
    
    //******************************************************
    //MARK: - Initializer
    //******************************************************
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //******************************************************
    //MARK: - NavigationBar Setting
    //******************************************************
    /**
     * @네비게이션 바 타이틀 설정
     * @creator : coder3306
     * @param title : 네비게이션 타이틀
     */
    private func setNavigationBarTitle(_ title: String) {
        navigationTitleLabel.text = title
        navigationTitleLabel.textColor = .black
        navigationTitleLabel.textAlignment = .center
        navigationTitleLabel.sizeToFit()
        let newSize = navigationTitleLabel.sizeThatFits(navigationTitleLabel.frame.size)
        containerView.addSubview(navigationTitleLabel)
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.containerView)
            $0.width.equalTo(newSize.width)
        }
    }
    
    /**
     * @네비게이션 바 버튼 설정
     * @creator : coder3306
     * @param button : 각 컨트롤러에서 설정된 버튼 리스트
     * @param isLeft : 버튼의 위치 설정
     */
    private func setNavigationBarButton(_ button: [UIView], isLeft: Bool) {
        let stackView = UIStackView(arrangedSubviews: button)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints {
            if isLeft {
                $0.leading.equalTo(self.containerView).offset(15)
            } else {
                $0.trailing.equalTo(self.containerView).offset(-15)
            }
            $0.centerY.equalTo(self.containerView)
        }
    }
}

//MARK: - Create Navigation Bar
extension CustomNavigationBar {
    /**
     * @커스텀 네비게이션 바 생성
     * @creator : coder3306
     * @param title : 네비게이션 타이틀
     * @param leftBarButton : 네비게이션 왼쪽 버튼
     * @param rightBarButton : 네비게이션 오른쪽 버튼
     */
    public func setNavigationBar(_ title: String? = nil, leftBarButton: [UIView]? = nil, rightBarButton: [UIView]? = nil) {
        // 네비게이션 바 디폴트 생성
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
        
        // 타이틀 생성
        if let title = title {
            setNavigationBarTitle(title)
        }
        // 왼쪽 버튼이 있을 경우 생성
        if let leftBarButton = leftBarButton {
            setNavigationBarButton(leftBarButton, isLeft: true)
        }
        // 오른쪽 버튼이 있을 경우 생성
        if let rightBarButton = rightBarButton {
            setNavigationBarButton(rightBarButton, isLeft: false)
        }
    }
}
