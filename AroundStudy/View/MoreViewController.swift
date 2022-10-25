//  MoreViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/01.
//  더보기 메인

import UIKit

class MoreViewController: BaseViewController {
    /// 더보기 메인 테이블 뷰
    @IBOutlet weak var tableMoreMain: UITableView?
    /// 프로필 정보 수정 알림 뷰
    @IBOutlet weak var modifyCompleteView: UIView?
    
    /// 더보기 메인화면 셀 리스트
    private var cells = [
        MoreUserInfoTableViewCell.self
        , MoreStudyTitle.self
        , MoreStudyItem.self
        , MoreStudyTitle.self
        , MoreStudyItem.self
    ]
    
    /**
     * @더보기 화면 초기화
     * @creator : coder3306
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initTableViewCell()
        initLayout()
    }
    
    /**
     * @더보기 메인 레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        modifyCompleteView?.layer.setBorderLayout(radius: 8)
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

//MARK: - tableViewExtension
extension MoreViewController: tableViewExtension {
    /**
     * @더보기 메인 - 테이블 뷰 셀 초기화
     * @creator : coder3306
     */
    private func initTableViewCell() {
        for cell in cells {
            tableMoreMain?.register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }
    
    /**
     * @더보기 메인 - 테이블뷰 로우 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    /**
     * @더보기 메인 - 테이블 뷰 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cells.reuseIdentifier, for: indexPath)
        switch indexPath.row {
            case 0:
                if let cell = cell as? MoreUserInfoTableViewCell {
                    cell.didSelectModify {
                        let profile = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
                        profile.delegate = self
                        self.navigationController?.pushViewController(profile, animated: true)
                    }
                    return cell
                }
            case 1:
                if let cell = cell as? MoreStudyTitle {
                    cell.studyTitle.text = "최근 본 스터디"
                    return cell
                }
            case 2:
                if let cell = cell as? MoreStudyItem {
                    return cell
                }
            case 3:
                if let cell = cell as? MoreStudyTitle {
                    cell.studyTitle.text = "찜한 스터디"
                    return cell
                }
            case 4:
                if let cell = cell as? MoreStudyItem {
                    return cell
                }
            default:
                return UITableViewCell()
        }
        return cell
    }
    
    /**
     * @더보기 메인 - 테이블 뷰 높이 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 || indexPath.row == 4 {
            return 200
        }
        return UITableView.automaticDimension
    }
}

//MARK: Action
extension MoreViewController: ProfileEditCompleteDelegate {
    /**
     * @더보기 - 세팅화면 이동
     * @creator : coder3306
     * @param sender : UIButton
     */
    @objc private func moveSetting(_ sender: UIButton) {
        print("Move Setting")
    }
    
    /**
     * @프로필 수정 완료 후 애니메이션 설정
     * @creator : coder3306
     */
    func didCompleteEdit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.modifyCompleteView?.isHidden = false
            UIView.animate(withDuration: 0.35) {
                self.modifyCompleteView?.transform = CGAffineTransform(translationX: 0, y: -60)
            } completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.modifyCompleteView?.isHidden = true
                    self.modifyCompleteView?.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }
        }
    }
}
