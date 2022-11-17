//
//  SearchLocationViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/16.
//

import UIKit
import Alamofire

class SearchAddressViewController: BaseViewController {
    /// 주소검색 결과 노출 테이블 뷰
    @IBOutlet weak var tableSearchAddress: UITableView?
    /// 네비게이션 뒤로가기
    @IBOutlet weak var btnBack: UIButton?
    /// 검색 뷰
    @IBOutlet weak var viewSearch: UIView?
    /// 주소검색 텍스트필드
    @IBOutlet weak var tfAddress: UITextField?
    
    /// 검색된 결과 설정
    private var searchResult = [Address]()
    /// 주소 검색 셀
    private var cells = [
        SearchCurrentAddressTableViewCell.self
        , SearchAddressTableViewCell.self
    ]
    /// 검색된 주소 전달 핸들러
    private var address: dataClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableViewCell()
        initLayout()
    }
    
    /**
     * @레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        viewSearch?.layer.setBorderLayout(radius: 8)
        btnBack?.addTarget(self, action: #selector(popToView(_:)), for: .touchUpInside)
    }
    
    /**
     * @주소 검색 요청
     * @creator : coder3306
     */
    private func searchAddress(_ requestAddressName: String) {
        let headers: HTTPHeaders = [
            //FIXME: - 헤더 위치 히든처리 필요함.
            "Authorization": "KakaoAK 14524f0b57fdfcd9f4a8f3892db1b0ff"
        ]
        let parameters: [String: Any] = [
            "query": requestAddressName,
            "page": 15,
            "size": 10
        ]
        self.searchResult.removeAll()
        //FIXME: API Indicator 설정 필요
        Task {
            do {
                let value = try await APIManager.shared.requestJSON(url: "https://dapi.kakao.com/v2/local/search/address.json", type: Documents.self, method: .get, param: parameters, header: headers)
                searchResult = value.documents
                self.tableSearchAddress?.reloadData()
            } catch let error {
                print(error)
                self.tableSearchAddress?.reloadData()
            }
        }
    }
    
    /**
     * @검색된 주소 전달 메서드
     * @creator : coder3306
     * @Return : 검색된 주소 정보를 클로저로 콜백, 전달
     */
    public func didSelectAddress(_ complete: @escaping dataClosure) {
        self.address = complete
    }
}

//MARK: - tableViewExtension
extension SearchAddressViewController: tableViewExtension {
    /**
     * @테이블뷰 셀 초기화
     * @creator : coder3306
     */
    private func initTableViewCell() {
        if let tableSearchAddress = tableSearchAddress {
            SearchCurrentAddressTableViewCell.registerXib(targetView: tableSearchAddress)
            SearchAddressTableViewCell.registerXib(targetView: tableSearchAddress)
        }
    }
    
    /**
     * @테이블뷰 섹션 초기화
     * @creator : coder3306
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /**
     * @테이블뷰 로우 갯수 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 1 : searchResult.count
    }
    
    /**
     * @테이블뷰 아이템 초기화
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableSearchAddress = tableSearchAddress else {
            return UITableViewCell()
        }
        
        let cell = cells[indexPath.section]
        if cell == SearchCurrentAddressTableViewCell.self {
            if let itemCell = SearchCurrentAddressTableViewCell.dequeueReusableCell(targetView: tableSearchAddress) {
                itemCell.selectionStyle = .none
                itemCell.didUpdateCurrentLocation { [weak self] location in
                    DispatchQueue.main.async {
                        if let location = location as? String {
                            self?.searchAddress(location)
                        }
                    }
                }
                return itemCell
            }
        } else if cell == SearchAddressTableViewCell.self {
            if let itemCell = SearchAddressTableViewCell.dequeueReusableCell(targetView: tableSearchAddress) {
                itemCell.selectionStyle = .none
                itemCell.lblSearchResult?.text = searchResult[indexPath.row].addressName
                itemCell.viewBorder?.isHidden = (indexPath.row == searchResult.count - 1) ? true : false
                return itemCell
            }
        }
        return UITableViewCell()
    }
    
    /**
     * @테이블뷰 셀 선택시 동작 설정
     * @creator : coder3306
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        address?(searchResult[indexPath.row].addressName)
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: UITextFieldDelegate
extension SearchAddressViewController: UITextFieldDelegate {
    /**
     * @텍스트필드 리턴 버튼 동작 설정
     * @creator : coder3306
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.searchAddress(textField.text ?? "")
        return true
    }
}
