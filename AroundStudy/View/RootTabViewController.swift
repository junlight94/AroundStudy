//
//  RootTabViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/28.
//

import UIKit

class RootTabViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var imgHomeTab: UIImageView!
    @IBOutlet weak var imgStudyTab: UIImageView!
    @IBOutlet weak var imgChatTab: UIImageView!
    @IBOutlet weak var imgMoreTab: UIImageView!
    
    
    lazy var viewControllers = [
        HomeViewController(nibName: "HomeViewController", bundle: nil),
        StudyViewController(nibName: "StudyViewController", bundle: nil),
        ChattingViewController(nibName: "ChattingViewController", bundle: nil),
        MoreViewController(nibName: "MoreViewController", bundle: nil)
    ]
    
    let tabIcon = [["home_inactive","home_active"], ["study_inactive","study_active"],
                   ["chat_inactive", "chat_active"], ["more_inactive","more_active"]]
    
    lazy var imgTab = [imgHomeTab, imgStudyTab, imgChatTab, imgMoreTab]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    //MARK: - General Function
    func setupView() {
        changeTap(view: 0)
    }
    
    func changeTap(view: Int) {
        if let sub = viewContainer.subviews.first {
            sub.removeFromSuperview()
        }
        
        let vc = viewControllers[view]
        
        addChild(vc)
        
        viewContainer.addSubview(vc.view)
        
        for i in 0..<imgTab.count {
            guard let imgView = imgTab[i] else { return }
            
            if i == view {
                imgView.image = UIImage(named: tabIcon[i][1])
            } else {
                imgView.image = UIImage(named: tabIcon[i][0])
            }
            
        }
        
        vc.view.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        vc.didMove(toParent: self)
    }
    
    //MARK: - Selector Function
        
    //MARK: - IBAction Function
    @IBAction func btnChangeTab(_ sender: UIButton) {
        changeTap(view: sender.tag)
    }
}
//MARK: - Extension
