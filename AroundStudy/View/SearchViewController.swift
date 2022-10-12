//
//  SearchViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/10.
//

import UIKit
import RealmSwift

class SearchViewController: BaseViewController {

    @IBOutlet weak var tfSearch: TextField_Search!
    @IBOutlet weak var hotStudyCollectionView: UICollectionView!
    @IBOutlet weak var historyCollectionView: UICollectionView!
    @IBOutlet weak var historyCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    
    @IBOutlet weak var pcHotStudy: UIPageControl!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var textField: TextField_Search!
    
    let realm = try! Realm(configuration: DataManager.shared.realmConfiguration())
    
    var hotStudy = 3
    var currentIndex = 0
    
    var hotStudyData: [StudyDto] = [] {
        didSet {
            DispatchQueue.main.async {
                self.hotStudyCollectionView.reloadData()
            }
        }
    }
    
    var searchHistoryData: [SearchHistoryDB] = [] {
        didSet {
            DispatchQueue.main.async {
                print("historyDataChange")
                self.historyCollectionView.reloadData()
            }
        }
    }
    
    var filterHistoryData: [SearchHistoryDB] = [] {
        didSet {
            DispatchQueue.main.async {
                print("filterHistoryDataChange")
                self.searchHistoryData = self.realm.objects(SearchHistoryDB.self).sorted(byKeyPath: "date", ascending: false).map{$0}
                self.searchHistoryTableView.reloadData()
            }
        }
    }
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    //MARK: - General Function
    func setupView() {
        //CollectionView
        hotStudyCollectionView.delegate = self
        hotStudyCollectionView.dataSource = self
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        
        
        hotStudyCollectionView.register(UINib(nibName: "HotStudyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HotStudyCollectionViewCell")
        historyCollectionView.register(UINib(nibName: "SearchHistoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchHistoryCollectionViewCell")
        searchHistoryTableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
        
        hotStudyCollectionView.isPagingEnabled = false
        hotStudyCollectionView.decelerationRate = .fast
        
        //dummyData
        hotStudyData.append(StudyDto(title: "스터디 이름이 들어가는 영역으로 두줄까지 입니다..", category: "IT", process: "비대면", people: 6, favorite: true))
        hotStudyData.append(StudyDto(title: "스위프트 스터디", category: "IT", process: "대면", people: 12, favorite: false))
        hotStudyData.append(StudyDto(title: "알고리즘 스터디", category: "IT", process: "비대면", people: 3, favorite: true))
        hotStudyData.append(StudyDto(title: "네카라쿠배토당 알고리즘 스터디", category: "취업", process: "대면", people: 122, favorite: false))
        hotStudyData.append(StudyDto(title: "토익 스터디", category: "영어", process: "대면", people: 33, favorite: true))
        
        textField.addTarget(self, action: #selector(editing), for: .editingChanged)
        textField.addTarget(self, action: #selector(endEditing), for: .editingDidEnd)
        
        pcHotStudy.numberOfPages = hotStudyData.count
        
        searchHistoryData = realm.objects(SearchHistoryDB.self).sorted(byKeyPath: "date", ascending: false).map{$0}
        
        print("junyoung > SearchHistoryDB : ", realm.objects(SearchHistoryDB.self))
        print("junyoung > searchHistoryData : ", searchHistoryData)
    }
    
    func updateView() {
        
    }
        
    //MARK: - Selector Function
    @objc func btnFavoriteOnClick(_ sender: UIButton) {
        hotStudyData[sender.tag].favorite.toggle()
    }
    
    @objc func endEditing(_ textField: UITextField) {
        print("junyoung > \(#function)")
        let now = Date()
        if let text = textField.text {
            print("junyoung > text done : ", text)
            if text.count > 0 {
                try? realm.write {
                    let realmData = SearchHistoryDB()
                    realmData.title = text
                    realmData.date = now
                    realm.add(realmData)
                }
            }
        }
    }
    
    @objc func editing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count > 0 {
                viewSearch.isHidden = false
                filterHistoryData = searchHistoryData.filter{$0.title.contains(text)}
//                filterHistoryData = realm.objects(SearchHistoryDB.self).sorted(byKeyPath: "date", ascending: false).map{$0}
            } else {
                viewSearch.isHidden = true
            }
        }
    }
    
    //MARK: - IBAction Function
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditPressed(_ sender: Any) {
        
    }
    
    
}
//MARK: - Extension

//MARK: UITableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterHistoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell", for: indexPath) as! SearchHistoryTableViewCell
        let row = filterHistoryData[indexPath.row]
        cell.lbTitle.text = row.title
        return cell
    }
    
    
}

//MARK: UICollectionView
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hotStudyCollectionView {
            return hotStudyData.count
        } else {
            return searchHistoryData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == hotStudyCollectionView {
            let width = UIScreen.main.bounds.size.width - 40
            return CGSize(width: width, height: 85)
        } else {
            return CGSize(width: 100, height: 37)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotStudyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotStudyCollectionViewCell", for: indexPath) as! HotStudyCollectionViewCell
            let item = hotStudyData[indexPath.item]
            
            cell.lbTitle.text = item.title
            cell.lbCategory.text = item.category
            cell.lbSubCategory.text = item.category
            cell.lbSubPeople.text = String(item.people)+"명"
            
            cell.btnFavorite.tag = indexPath.item
            cell.btnFavorite.addTarget(self, action: #selector(btnFavoriteOnClick), for: .touchUpInside)
            if item.favorite == true {
                cell.btnFavorite.setImage(UIImage(named: "favorite_fill"), for: .normal)
            } else {
                cell.btnFavorite.setImage(UIImage(named: "favorite"), for: .normal)
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchHistoryCollectionViewCell", for: indexPath) as! SearchHistoryCollectionViewCell
            let item = searchHistoryData[indexPath.item]
            cell.lbTitle.text = item.title
            return cell
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let scroll = scrollView as? UICollectionView {
            let layout = scroll.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = round((offset.x + scroll.contentInset.left) / cellWidth)
            
            if index > CGFloat(currentIndex) {
                currentIndex += 1
            } else if index < CGFloat(currentIndex) {
                if currentIndex != 0 {
                    currentIndex -= 1
                }
            }
            offset = CGPoint(x: CGFloat(currentIndex) * cellWidth - scrollView.contentInset.left, y: 0)
            
            targetContentOffset.pointee = offset
            
            pcHotStudy.currentPage = currentIndex
        }
    }
    
    
}
