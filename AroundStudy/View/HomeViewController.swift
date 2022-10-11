//
//  HomeViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/01.
//

import UIKit

class HomeViewController: UIViewController {
    
    //******************************************************
    //MARK: - 더미데이터
    //******************************************************
    let studyCellData: [[String]] = [
        ["스터디 제목", "디자인", "강남구", "28"],
        ["스터디 제목인데 이건 두줄을 위한", "디자인", "서초구", "52"],
        ["스터디 제목", "디자인", "해운대구", "8"],
        ["스터디 제목", "디자인", "몰라몰라", "1"],
        ["스터디 제목인데 이건 두줄을 위한", "디자인", "지역", "108"],
        ["스터디 제목인데 이건 두줄을 위한", "디자인", "지역", "999"],
        ["스터디 제목", "디자인", "지역", "8"],
        ["스터디 제목", "디자인", "지역", "22"],
        ["스터디 제목인데 이건 두줄을 위한", "디자인", "지역", "7"],
        ["스터디 제목", "디자인", "지역", "22"],
        ["스터디 제목인데 이건 두줄을 위한", "디자인", "지역", "7"],
        ["스터디 제목인데 이건 두줄을 위한", "디자인", "지역", "999"],
        ["스터디 제목", "디자인", "지역", "8"],
        ["스터디 제목", "디자인", "지역", "22"],
        ["스터디 제목인데 이건 두줄을 위한", "디자인", "지역", "7"]
    ]

    @IBOutlet weak var customNavagationBar: CustomNavigationBar!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var studyCollectionView: UICollectionView!
    @IBOutlet weak var categoryOneView: UIView!
    @IBOutlet weak var categoryTwoView: UIView!
    
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    let categoryButton = UIButton(type: .custom)
    let searchButton = UIButton(type: .custom)
    
    /// 테스트용 뷰들
    @IBOutlet weak var tempTopView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTemp()
        setupNavagationBar()
        setupView()
        // Do any additional setup after loading the view.
    }
}

extension HomeViewController {
    /**
     테스트용 코드
     - 실 개발시는 꼭 삭제하고 작업해야합니다!
     > coder : sanghyeon
     */
    func setupTemp() {
        tempTopView.layer.cornerRadius = 12
    }
    /**
     네비게이션바 설정
     - 뷰가 로드된 후 네비게이션바를 설정합니다.
     > coder : sanghyeon
     */
    func setupNavagationBar() {
        /// 기존 네비게이션바 삭제
        navigationController?.navigationBar.isHidden = true
        categoryButton.setImage(UIImage(named: "category"), for: .normal)
        searchButton.setImage(UIImage(named: "search"), for: .normal)
        customNavagationBar.setNavigationBar(rightBarButton: [categoryButton, searchButton])
    }
    /**
     초기 레이아웃 설정
     - 뷰가 로드된 후 처음 레이아웃을 설정합니다.
     > coder : sanghyeon
     */
    func setupView() {
        /// 카테고리 컬렉션뷰 설정
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        let categoryCellNib = UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil)
        categoryCollectionView.register(categoryCellNib, forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        
        /// 스터디 컬렉션뷰 설정
        studyCollectionView.delegate = self
        studyCollectionView.dataSource = self
        let studyCellNib = UINib(nibName: "StudyInfoGridCollectionViewCell", bundle: nil)
        studyCollectionView.register(studyCellNib, forCellWithReuseIdentifier: "StudyInfoGridCollectionViewCell")
        
        /// 카테고리 필터 보더 및 코너라운딩
        categoryOneView.layer.borderWidth = 1
        categoryOneView.layer.borderColor = UIColor(named: "236")?.cgColor
        categoryOneView.layer.cornerRadius = 8
        categoryTwoView.layer.borderWidth = categoryOneView.layer.borderWidth
        categoryTwoView.layer.borderColor = categoryOneView.layer.borderColor
        categoryTwoView.layer.cornerRadius = categoryOneView.layer.cornerRadius
        
        searchButton.addTarget(self, action: #selector(btnSearchPressed), for: .touchUpInside)
    }
    
    @objc func btnSearchPressed() {
        let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return 20
        case studyCollectionView:
            return studyCellData.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return setupCollectionViewCell(collectionView, indexPath: indexPath)
    }
    
    /**
     컬렉션뷰 셀 사이즈 변경
     - 인터페이스빌더에서 설정하려 하였으나, 화면 사이즈에 맞게 변경해야할 필요가 있어서 코드로 처리함
     > coder : sanghyeon
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoryCollectionView:
            return CGSize(width: 64, height: 60)
        case studyCollectionView:
            /// screenWidth : 현재 화면의 해상도 너비 사이즈
            let screenWidth = view.frame.width
            /// 셀 한개의 너비 지정
            let cellWidth = (screenWidth - 55) / 2
            
            /// 컨텐츠뷰 사이즈 조정
            /// studyCollectionViewY : 컬렉션뷰 직전까지의 높이 길이
            let studyCollectionViewY = studyCollectionView.frame.minY
            /// studyCollectionViewHeight : 컬렉션뷰 셀 줄의 따라 컬렉션뷰 사이즈
            let studyCollectionViewHeight = ceil(Double(studyCellData.count) / 2) * 210
            /// studyCollectionViewY + studyCollectionViewHeight = 컨텐츠뷰 사이즈
            contentViewHeightConstraint.constant = studyCollectionViewY + CGFloat(studyCollectionViewHeight)
            return CGSize(width: cellWidth, height: 178)
        default: return .zero
        }
    }
    
    
    
    /**
     컬렉션뷰 셀 설정 대체 함수
     - 기본으로 제공하는 함수를 대체하여 사용합니다.
     > coder : sanghyeon
     */
    func setupCollectionViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as? HomeCategoryCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case studyCollectionView:
            guard let cell = studyCollectionView.dequeueReusableCell(withReuseIdentifier: "StudyInfoGridCollectionViewCell", for: indexPath) as? StudyInfoGridCollectionViewCell else { return UICollectionViewCell() }
            let cellData = studyCellData[indexPath.row]
            cell.setupCell("\(indexPath.row + 1) \(cellData[0])", category: cellData[1], location: cellData[2], memberCount: Int(cellData[3]) ?? 0)
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    
    
}
