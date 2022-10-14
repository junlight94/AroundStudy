//
//  StudyDetailViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/13.
//

import UIKit

class StudyDetailViewController: BaseViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var ivMainImage: UIImageView!
    @IBOutlet weak var viewMainImageHeight: NSLayoutConstraint!
    @IBOutlet weak var mainImageTop: NSLayoutConstraint!
    @IBOutlet weak var viewCreate: UIView!
    @IBOutlet weak var lbCreateDate: UILabel!
    
    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var infoUnderLine: UIView!
    @IBOutlet weak var infoUnderLineHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lbSchedule: UILabel!
    @IBOutlet weak var scheduleUnderLine: UIView!
    @IBOutlet weak var scheduleUnderLineHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lbVote: UILabel!
    @IBOutlet weak var voteUnderLine: UIView!
    @IBOutlet weak var voteUnderLineHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var studyId: Int?
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    //MARK: - General Function
    func setupView() {
        seleteTap(index: 0)
        scrollView.delegate = self
        
        viewCreate.layer.cornerRadius = 20
        lbCreateDate.text = "개설일 22.10.14"
        if let studyId = studyId {
            lbTitle.text = "id : \(studyId) 스터디"
        }
    }
    
    func seleteTap(index: Int) {
        switch index {
        case 0:
            lbInfo.textColor = UIColor(named: "40")
            infoUnderLine.backgroundColor = UIColor(named: "40")
            infoUnderLineHeight.constant = 3
            
            lbSchedule.textColor = UIColor(named: "173")
            scheduleUnderLine.backgroundColor = UIColor(named: "236")
            scheduleUnderLineHeight.constant = 1
            
            lbVote.textColor = UIColor(named: "173")
            voteUnderLine.backgroundColor = UIColor(named: "236")
            voteUnderLineHeight.constant = 1
        case 1:
            lbInfo.textColor = UIColor(named: "173")
            infoUnderLine.backgroundColor = UIColor(named: "236")
            infoUnderLineHeight.constant = 1
            
            lbSchedule.textColor = UIColor(named: "40")
            scheduleUnderLine.backgroundColor = UIColor(named: "40")
            scheduleUnderLineHeight.constant = 3
            
            lbVote.textColor = UIColor(named: "173")
            voteUnderLine.backgroundColor = UIColor(named: "236")
            voteUnderLineHeight.constant = 1
        case 2:
            lbInfo.textColor = UIColor(named: "173")
            infoUnderLine.backgroundColor = UIColor(named: "236")
            infoUnderLineHeight.constant = 1
            
            lbSchedule.textColor = UIColor(named: "173")
            scheduleUnderLine.backgroundColor = UIColor(named: "236")
            scheduleUnderLineHeight.constant = 1
            
            lbVote.textColor = UIColor(named: "40")
            voteUnderLine.backgroundColor = UIColor(named: "40")
            voteUnderLineHeight.constant = 3
        default:
            break
        }
    }
    
    //MARK: - Selector Function
    
    //MARK: - IBAction Function
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnFavoritePressed(_ sender: Any) {
        
    }
    
    @IBAction func btnSharedPressed(_ sender: Any) {
        
    }
    
    @IBAction func btnInfoPressed(_ sender: Any) {
        seleteTap(index: 0)
    }
    
    @IBAction func btnSchedulePressed(_ sender: Any) {
        seleteTap(index: 1)
    }
    
    @IBAction func btnVotePressed(_ sender: Any) {
        seleteTap(index: 2)
    }
}
//MARK: - Extension
extension StudyDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 200 {
            viewMainImageHeight.constant = 0
        } else {
            viewMainImageHeight.constant = 200 - scrollView.contentOffset.y
        }
        
        if scrollView.contentOffset.y > 200 {
            mainImageTop.constant = -200
        } else {
            mainImageTop.constant = -scrollView.contentOffset.y
        }
    }
}
