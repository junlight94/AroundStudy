//
//  RootTabViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/09/28.
//

import UIKit

class RootTabViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    
    lazy var viewControllers = [
        HomeViewController(nibName: "HomeViewController", bundle: nil),
        StudyViewController(nibName: "StudyViewController", bundle: nil),
        ChattingViewController(nibName: "ChattingViewController", bundle: nil),
        MoreViewController(nibName: "MoreViewController", bundle: nil)
    ]
    
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
