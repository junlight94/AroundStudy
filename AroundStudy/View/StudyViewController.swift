//
//  StudyViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/01.
//

import UIKit

class StudyViewController: BaseViewController {
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - General Function
    func setupView() {
        let btnSearch = UIButton()
        btnSearch.setImage(UIImage(named: "search"), for: .normal)
        btnSearch.addTarget(self, action: #selector(btnSearchPressed), for: .touchUpInside)
        setNavigationBar("스터디", leftBarButton: nil, rightBarButton: [btnSearch], isLeftSetting: true)
    }
        
    //MARK: - Selector Function
    
    // 검색 페이지로 이동
    @objc func btnSearchPressed(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - IBAction Function

}
//MARK: - Extension
