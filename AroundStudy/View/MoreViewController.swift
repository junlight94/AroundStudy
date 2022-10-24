//  MoreViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/01.
//  더보기 메인

import UIKit

class MoreViewController: BaseViewController {
    @IBOutlet weak var tableMore: UITableView?
    
    /**
     * @더보기 화면 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    
    /**
     * @네비게이션 바 초기화
     * @creator : coder3306
     */
    private func initNavigationBar() {
        let setting = UIButton(type: .custom)
        setting.setImage(UIImage(named: "setting"), for: .normal)
        setting.addTarget(self, action: #selector(moveSetting(_:)), for: .touchUpInside)
        setNavigationBar("더보기", rightBarButton: [setting], isLeftSetting: true)
    }
}

//MARK: Action
extension MoreViewController {
    /**
     * @더보기 - 세팅화면 이동
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func moveSetting(_ sender: UIButton) {
        print("Move Setting")
    }
}

extension MoreViewController: tableViewExtension {
    private func initTableViewCell() {
        if let tableMore = tableMore {
            MoreUserInfoTableViewCell.registerXib(targetView: tableMore)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableMore = tableMore else {
            return UITableViewCell()
        }
        //FIXME: - 테스트 할것(코드로 짜기)
        return UITableViewCell()
    }
}
