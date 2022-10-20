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
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewContentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewFloating: UIView!
    
    
    var pageController: UIPageViewController?
    lazy var pageContent = [StudyInfoViewController(nibName: "StudyInfoViewController", bundle: nil),
    AddPlanViewController(nibName: "AddPlanViewController", bundle: nil),
    VoteViewController(nibName: "VoteViewController", bundle: nil)]
    
    var studyId: Int?
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(viewHeight), name: NSNotification.Name("viewHeight"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("viewHeight"), object: nil)
    }
    
    //MARK: - General Function
    func setupView() {
        seleteTap(index: 0)
        scrollView.delegate = self
        
        viewCreate.layer.cornerRadius = 13
        lbCreateDate.text = "개설일 22.10.14"
        if let studyId = studyId {
            lbTitle.text = "id : \(studyId) 스터디"
        }
        
        viewFloating.layer.cornerRadius = viewFloating.frame.width / 2
        
        // PageViewController
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        guard let pageController = pageController else { return }
        pageController.delegate = self
        pageController.dataSource = self
        pageController.setViewControllers([pageContent.first!], direction: .forward, animated: true, completion: nil)
        
        viewContent.addSubview(pageController.view)
        let pageViewRect = viewContent.bounds
        
        pageController.view.frame = pageViewRect
        pageController.didMove(toParent: self)
        
        seleteTap(index: 0)
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
    @objc func viewHeight(_ notification: Notification) {
        if let viewHeight = notification.object as? CGFloat {
            viewContentHeight.constant = viewHeight
            print(viewContentHeight.constant)
        }
    }
    
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
        guard let pageController = pageController else { return }
        pageController.setViewControllers([pageContent[0]], direction: .forward, animated: true, completion: nil)
    }
    
    @IBAction func btnSchedulePressed(_ sender: Any) {
        seleteTap(index: 1)
        guard let pageController = pageController else { return }
        pageController.setViewControllers([pageContent[1]], direction: .forward, animated: true, completion: nil)
    }
    
    @IBAction func btnVotePressed(_ sender: Any) {
        seleteTap(index: 2)
        guard let pageController = pageController else { return }
        pageController.setViewControllers([pageContent[2]], direction: .forward, animated: true, completion: nil)
    }
}
//MARK: - Extension

//MARK: UIScrollView
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

//MARK: UIPageViewController
extension StudyDetailViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func indexOfViewController(_ viewController: UIViewController) -> Int {
        let size = pageContent.count
        for i in 0..<size {
            if viewController == pageContent[i] {
                return i
            }
        }
        return -1
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIdx = indexOfViewController(viewController)
        let prevPageIndex = currentIdx - 1
        if prevPageIndex < 0 {
            return nil
        } else {
            return pageContent[prevPageIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIdx = indexOfViewController(viewController)
        let prevPageIndex = currentIdx + 1
        if prevPageIndex >= pageContent.count {
            return nil
        } else {
            return pageContent[prevPageIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            let index: Int = self.indexOfViewController(pageViewController.viewControllers![0])
            seleteTap(index: index)
        }
    }
}
