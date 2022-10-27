//
//  StudyDetailViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/13.
//

import UIKit
import FloatingPanel

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
    
    let MaxTopHeight: CGFloat = 200
    let MinTopHeight: CGFloat = 0
    
    var currentIndex: Int = 0
    
    var pageController: UIPageViewController?
    lazy var pageContent = [StudyInfoViewController(nibName: "StudyInfoViewController", bundle: nil),
    PlanMainViewController(nibName: "PlanMainViewController", bundle: nil),
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
        NotificationCenter.default.addObserver(self, selector: #selector(showSchedulePopup), name: .showSchedulePopup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showAddVoteView), name: .showAddVoteView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveVC), name: NSNotification.Name("viewController"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("viewHeight"), object: nil)
        NotificationCenter.default.removeObserver(self, name: .showSchedulePopup, object: nil)
        NotificationCenter.default.removeObserver(self, name: .showAddVoteView, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("viewController"), object: nil)
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
        viewContentHeight.constant = 670
        
        pageController.view.frame = pageViewRect
        pageController.didMove(toParent: self)
        
        seleteTap(index: 0)
    }
    
    func seleteTap(index: Int) {
        currentIndex = index
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
            let vcHeight = view.frame.height
            print("vcHeight: \(vcHeight), viewHeight: \(viewHeight)")
//            viewContentHeight.constant = viewHeight < vcHeight ? vcHeight + 200 : viewHeight
            viewContentHeight.constant = viewHeight
            
            print("viewContentHeight: ", viewContentHeight.constant)
        }
    }
    
    /**
     * @스케줄 팝업 뷰 호출
     * @creator : coder3306
     */
    @objc private func showSchedulePopup() {
        let vc = StudySchedulePopupViewController(nibName: "StudySchedulePopupViewController", bundle: nil)
        vc.isMultipleSelection = false
        floatingPanelController = FloatingPanelController(delegate: self)
        setupFloatingView(vc, targetScrollView: UIScrollView(), position: .half)
    }
    
    /**
     * @투표 추가하기 뷰 호출
     * @creator : coder3306
     */
    @objc private func showAddVoteView() {
        let vc = AddVoteViewController(nibName: "AddVoteViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moveVC(_ notification: Notification) {
        if let vc = notification.object as? String {
            switch vc {
                case "addPlan":
                    let vc = AddPlanViewController(nibName: "AddPlanViewController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                default: break
            }
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
        pageController.setViewControllers([pageContent[0]], direction: .reverse, animated: true, completion: nil)
    }
    
    @IBAction func btnSchedulePressed(_ sender: Any) {
        let direction: UIPageViewController.NavigationDirection = currentIndex > 1 ? .reverse : .forward
        seleteTap(index: 1)
        guard let pageController = pageController else { return }
        pageController.setViewControllers([pageContent[1]], direction: direction, animated: true, completion: nil)
    }
    
    @IBAction func btnVotePressed(_ sender: Any) {
        seleteTap(index: 2)
        guard let pageController = pageController else { return }
        DispatchQueue.main.async {
            pageController.setViewControllers([self.pageContent[2]], direction: .forward, animated: true, completion: nil)
        }
    }
}
//MARK: - Extension

//MARK: UIScrollView
extension StudyDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //현재 스크롤의 위치 (최상단 = 0)
        let y: CGFloat = scrollView.contentOffset.y
        
        //변경될 최상단 뷰의 높이
        let ModifiedTopHeight: CGFloat = viewMainImageHeight.constant - y
        
        if(ModifiedTopHeight > MaxTopHeight) {
            mainImageTop.constant = 0
            viewMainImageHeight.constant = MaxTopHeight
        } else if(ModifiedTopHeight < MinTopHeight) {
            mainImageTop.constant = -200
            viewMainImageHeight.constant = MinTopHeight
        } else {
            mainImageTop.constant = ModifiedTopHeight - 200
            viewMainImageHeight.constant = ModifiedTopHeight
            scrollView.contentOffset.y = 0
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
