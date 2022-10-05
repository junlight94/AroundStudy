//  TestTableViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/10/04.
//  화면 작업 중 테스트를 하기 위한 컨트롤러입니다.

import UIKit

class TestTableViewController: UITableViewController {
    enum TestList: Int {
        case main = 0
        
        var index: Int {
            return self.rawValue
        }
    }
}

extension TestTableViewController {
    /**
     * @클릭된 셀과 인덱스를 비교하여 테스트할 화면을 이동시켜주는 메서드입니다.
     * @사용법: 1. Main컨트롤러에 셀 추가. 2. 셀 인덱스에 맞는 위치에 TestList 이넘 데이터 추가 3. 셀렉트된 인덱스와 이넘값 비교하여 스토리보드 이동
     * @creator : coder3306
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == TestList.main.index {
            let main = UIViewController(nibName: "", bundle: nil)
            self.navigationController?.pushViewController(main, animated: true)
        }
    }
}
