//
//  JoinedStudyViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/13.
//

import UIKit

class JoinedStudyViewController: UIViewController {
    
    @IBOutlet weak var viewNoData: UIView!
    @IBOutlet weak var joinedStudyCollectionView: UICollectionView!
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: - General Function
    func setupView() {
        joinedStudyCollectionView.delegate = self
        joinedStudyCollectionView.dataSource = self
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        joinedStudyCollectionView.register(UINib(nibName: "StudyInfoGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StudyInfoGridCollectionViewCell")
        keywordCollectionView.register(UINib(nibName: "KeywordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "KeywordCollectionViewCell")
    }
    
    func cellSize(title: String) -> CGFloat{
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 15)
        label.text = title
        
        return label.intrinsicContentSize.width + 24
    }
    
    //MARK: - Selector Function
        
    //MARK: - IBAction Function

}
//MARK: - Extension
extension JoinedStudyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == joinedStudyCollectionView {
            let width = (UIScreen.main.bounds.width - 55) / 2
            return CGSize(width: width, height: 178)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as! KeywordCollectionViewCell
            let width = cellSize(title: cell.lbKeyword.text ?? "")
            return CGSize(width: width, height: 34)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == joinedStudyCollectionView {
            return 32
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == joinedStudyCollectionView {
            return 15
        } else {
            return 8
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == joinedStudyCollectionView {
            return 5
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == joinedStudyCollectionView {
            let cell = joinedStudyCollectionView.dequeueReusableCell(withReuseIdentifier: "StudyInfoGridCollectionViewCell", for: indexPath) as! StudyInfoGridCollectionViewCell
            
            return cell
        } else {
            let cell = keywordCollectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCollectionViewCell", for: indexPath) as! KeywordCollectionViewCell
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == joinedStudyCollectionView {
            print(indexPath.item)
            NotificationCenter.default.post(name: NSNotification.Name("push"), object: indexPath.item, userInfo: nil)
        } else {
            print(indexPath.item)
        }
    }
}
