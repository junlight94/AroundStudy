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
        
        
        viewInfo.layer.cornerRadius = 12
    }
    
    //MARK: - Selector Function
        
    
    //MARK: - IBAction Function
    @IBAction func btnViewAllPressed(_ sender: Any) {
        
    }
    
}
//MARK: - Extension
