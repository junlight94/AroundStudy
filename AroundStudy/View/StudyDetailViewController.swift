//
//  StudyDetailViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/13.
//

import UIKit

class StudyDetailViewController: BaseViewController {
    
    var studyId: Int?
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        if let studyId = studyId {
            print(studyId)
        }
    }
    
    //MARK: - General Function
        
    //MARK: - Selector Function
        
    //MARK: - IBAction Function

}
//MARK: - Extension
