//
//  CategoryViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/07.
//

import UIKit

class CategoryViewController: BaseViewController {
    /// 카테고리 컬렉션 뷰
    @IBOutlet weak var collectionCategory: UICollectionView?
    
    //******************************************************
    //MARK: - dummy
    //******************************************************
    let dummy = ["취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직","취업·이직"]
    
    /**
     * @카테고리 뷰 컨트롤러 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        setNavi()
    }
    
    /**
     * @네비게이션 바 설정
     * @creator : coder3306
     */
    private func setNavi() {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(popToView(_:)), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow_prev"), for: .normal)
        
        let search = UIButton(type: .custom)
        search.addTarget(self, action: #selector(actionSearch(_:)), for: .touchUpInside)
        search.setImage(UIImage(named: "arrow_next"), for: .normal)
        setNavigationBar("카테고리", leftBarButton: [button], rightBarButton: [search], isLeftSetting: true)
    }
}

//MARK: - collectionViewExtension
extension CategoryViewController: collectionViewExtension {
    /**
     * @카테고리 컬렉션뷰 초기화
     * @creator : coder3306
     */
    private func initCollectionView() {
        if let collectionView = collectionCategory {
            CategoryItemCollectionViewCell.registerXib(targetView: collectionView)
        }
    }
    
    /**
     * @카테고리 아이템 설정
     * @creator : coder3306
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    /**
     * @카테고리 컬렉션 뷰 셀 설정
     * @creator : coder3306
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let collectionView = collectionCategory, let cell = CategoryItemCollectionViewCell.dequeueReusableCell(targetView: collectionView, indexPath: indexPath) {
            cell.setData(dummy[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3
        return CGSize(width: size, height: size)
    }
}

//MARK: - Action
extension CategoryViewController {
    @objc private func actionSearch(_ sender: UIButton) {
    }
}
