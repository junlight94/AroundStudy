//
//  StudyInfoViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/20.
//

import UIKit

class StudyInfoViewController: UIViewController {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var lbProcess: UILabel!
    @IBOutlet weak var lbPlace: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var lbPeople: UILabel!
    
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    @IBOutlet weak var studyCollectionView: UICollectionView!
    
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("viewHeight"), object: viewContent.frame.height, userInfo: nil)
    }
    
    //MARK: - General Function
    func setupView() {
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(UINib(nibName: "MemberProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MemberProfileCollectionViewCell")
        
        
        studyCollectionView.delegate = self
        studyCollectionView.dataSource = self
        studyCollectionView.register(UINib(nibName: "StudyInfoGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StudyInfoGridCollectionViewCell")
        
        viewInfo.layer.cornerRadius = 12
    }
    
    //MARK: - Selector Function
        
    
    //MARK: - IBAction Function
    @IBAction func btnViewAllPressed(_ sender: Any) {
        
    }
    
}
//MARK: - Extension

//MARK: CollectionView
extension StudyInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case peopleCollectionView :
            return CGSize(width: 52, height: collectionView.frame.height)
        case studyCollectionView :
            return CGSize(width: 300, height: collectionView.frame.height)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case peopleCollectionView :
            return 10
        case studyCollectionView :
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case peopleCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberProfileCollectionViewCell", for: indexPath) as! MemberProfileCollectionViewCell
            return cell
        case studyCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudyInfoGridCollectionViewCell", for: indexPath) as! StudyInfoGridCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }

    }
    
    
}
