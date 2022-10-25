//  MoreStudyItem.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/24.
//  스터디

import UIKit

class MoreStudyItem: UITableViewCell {
    private lazy var studyItem: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.indicatorStyle = .default
        return collectionView
    }()
    
    //******************************************************
    //MARK: - Initializer
    //******************************************************
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        initCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        initCollectionView()
    }
    
    /**
     * @셀 설정
     * @creator : coder3306
     */
    private func setupCell() {
        contentView.addSubview(studyItem)
        
        studyItem.snp.makeConstraints { make in
            make.top.bottom.right.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
        }
        studyItem.delegate = self
        studyItem.dataSource = self
    }
}

//MARK: - collectionViewExtension
extension MoreStudyItem: collectionViewExtension {
    /**
     * @스터디 셀 컬렉션뷰 초기화
     * @creator : coder3306
     */
    private func initCollectionView() {
        let nib = UINib(nibName: "StudyInfoGridCollectionViewCell", bundle: nil)
        studyItem.register(nib, forCellWithReuseIdentifier: "StudyInfoGridCollectionViewCell")
    }
    
    /**
     * @스터디 셀 아이템 갯수 초기화
     * @creator : coder3306
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    /**
     * @스터디 아이템 셀 초기화
     * @creator : coder3306
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyInfoGridCollectionViewCell", for: indexPath) as? StudyInfoGridCollectionViewCell {
            cell.setupCell("타이틀12312312\n123123", category: "카테고리 123", location: "현재위치 123", memberCount: 25, isFavorite: true)
            return cell
        }
        return UICollectionViewCell()
    }
    
    /**
     * @스터디 아이템 셀 사이즈 설정
     * @creator : coder3306
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 235, height: 180)
    }
}
