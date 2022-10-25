//
//  DropDownView.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/10/24.
// 

import UIKit

class DropDownView: UIView {
    /// 드롭다운 델리게이트 채택시 처리
    var delegate: DropDownLargeDelegate? {
        willSet {
            if let delegate = newValue {
                /// 델리게이트를 채택한 뷰컨트롤러에 드롭다운 생성
                if let targetViewController = delegate as? UIViewController {
                    targetViewController.view.addSubview(self)
                    self.snp.makeConstraints { make in
                        make.height.equalTo(height)
                        make.width.equalTo(100)
                        make.top.equalTo(delegate.overOffset() ? delegate.dropDownTargetButton().snp.top : delegate.dropDownTargetButton().snp.bottom)
                        make.leading.equalTo(delegate.dropDownTargetButton())
                    }
                }
                /// 드롭다운 인디케이터 설정
                dropDownTableView.showsVerticalScrollIndicator = delegate.showIndicator?() ?? true
                dropDownTableView.showsHorizontalScrollIndicator = delegate.showIndicator?() ?? true
                
                delegate.dropDownTargetButton().addTarget(self, action: #selector(didTapDropDownTargetButton), for: .touchUpInside)
            }
        }
    }
    
    /// 드롭다운 테이블뷰
    let dropDownTableView = UITableView()
    
    /// 드롭다운 아이템 높이
    var itemHeight: CGFloat {
        get {
            let height = delegate?.dropDownHeight?() ?? 54
            dropDownTableView.rowHeight = height
            return height
        }
    }
    
    /// 드롭다운 출력 개수
    var maximumDropCount: Int {
        get {
            return delegate?.maximumDropCount?() ?? 5
        }
    }
    
    /// 드롭다운 아이템 배열
    var item: [DropDown]? {
        get {
            return delegate?.dropDownItem() as? [DropDown]
        }
    }
    
    /// 드롭다운 높이
    var height: CGFloat {
        get {
            guard let item = item else { return .zero}
            return item.count >= maximumDropCount ? CGFloat(maximumDropCount) * itemHeight : CGFloat(item.count) * itemHeight
        }
    }

    /// 드롭다운 너비
    var width: CGFloat {
        get {
            guard let item = item else { return .zero }
            var tempWidth: CGFloat = 0
            for i in 0...item.count - 1 {
                let totalLabelWidth = getLabelSize(text: item[i].title) + getLabelSize(text: item[i].subTitle ?? "") + 29 + 30
                if totalLabelWidth > tempWidth {
                    tempWidth = totalLabelWidth
                }
                
            }
            return tempWidth
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// 초기 설정
        self.isHidden = true
        
        /// 드롭다운 테이블뷰 설정
        dropDownTableView.separatorStyle = .none
        let dropDownCellNib = UINib(nibName: "DropDownTableViewCell", bundle: nil)
        dropDownTableView.register(dropDownCellNib, forCellReuseIdentifier: "DropDownTableViewCell")
        dropDownTableView.delegate = self
        dropDownTableView.dataSource = self
        
        let backgroundView: UIView = {
            let backgroundView = UIView()
            backgroundView.layer.zeplinShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 4, spread: 0)
            return backgroundView
        }()
        
        let innerView: UIView = {
            let innerView = UIView()
            innerView.layer.cornerRadius = 12
            innerView.clipsToBounds = true
            return innerView
        }()
        
        innerView.addSubview(dropDownTableView)
        backgroundView.addSubview(innerView)
        addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        innerView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundView)
        }
        dropDownTableView.snp.makeConstraints { make in
            make.edges.equalTo(innerView)
        }
                
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

//MARK: - Functions
extension DropDownView {
    /// 라벨 사이즈 가져오기
    func getLabelSize(text: String? = nil) -> CGFloat {
        guard let text = text else { return .zero }
        let tempLabel: UILabel = {
            let tempLabel = UILabel()
            tempLabel.text = text
            tempLabel.font = .setCustomFont(.regular, size: 16)
            tempLabel.sizeToFit()
            return tempLabel
        }()
        
        return tempLabel.frame.width
    }
    
    /// 드롭다운 타겟버튼 이벤트
    @objc func didTapDropDownTargetButton() {
        //print("드롭다운 타겟버튼 클릭됨, self.isHidden: \(self.isHidden), width: \(width), height: \(height)")
        self.snp.updateConstraints { make in
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        if self.isHidden {
            self.isHidden = false
            if let image = delegate?.activeDropDownButtonImage?() {
                delegate?.dropDownTargetButton().setImage(image, for: .normal)
            }
        } else {
            self.isHidden = true
            if let image = delegate?.disableDropDownButtonImage?() {
                delegate?.dropDownTargetButton().setImage(image, for: .normal)
            }
        }
    }
}

//MARK: - TableView
extension DropDownView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let item = item else { return 0 }
        return item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = item else { return UITableViewCell() }
        guard let cell = dropDownTableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell else { return UITableViewCell() }
        let title = item[indexPath.row].title
        var subTitle: String = ""
        if let tempSubTitle = item[indexPath.row].subTitle {
            subTitle = tempSubTitle
        }
        cell.setFont(font: delegate?.itemFont?())
        cell.setupCell(title, subTitle: subTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = item else { return }
        delegate?.tappedDropDown(item: item[indexPath.row].title)
        if let changeTitle = delegate?.changeDropDownButtonTitle() {
            if changeTitle {
                delegate?.dropDownTargetButton().setTitle(item[indexPath.row].title, for: .normal)
            }
        }
        if let image = delegate?.disableDropDownButtonImage?() {
            delegate?.dropDownTargetButton().setImage(image, for: .normal)
        }
        self.isHidden = true
    }
    
    
}
