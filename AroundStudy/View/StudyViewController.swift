//
//  StudyViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/01.
//

import UIKit

class StudyViewController: BaseViewController {
    
    @IBOutlet weak var viewContent: UIView!
    
    var pageController: UIPageViewController?
    @IBOutlet weak var lbJoined: UILabel!
    @IBOutlet weak var lbFavorite: UILabel!
    @IBOutlet weak var viewLineJoined: UIView!
    @IBOutlet weak var viewLineFavorite: UIView!
    
    lazy var pageContent = [JoinedStudyViewController(nibName: "JoinedStudyViewController", bundle: nil),
                            FavoriteStudyViewController(nibName: "FavoriteStudyViewController", bundle: nil)]
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(pushView), name: NSNotification.Name("push"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("push"), object: nil)
    }
    
    //MARK: - General Function
    func setupView() {
        // Navigation
        let btnSearch = UIButton()
        btnSearch.setImage(UIImage(named: "search"), for: .normal)
        btnSearch.addTarget(self, action: #selector(btnSearchPressed), for: .touchUpInside)
        let naviItems = NavigationBarItems(title: "스터디", leftBarButton: nil, rightBarButton: [btnSearch], isLeftSetting: true)
        setNavigationBar(naviItems: naviItems)
        
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
        
        currentPageHighLight(page: 0)

    }
    
    func currentPageHighLight(page: Int) {
        if page == 0 {
            lbJoined.textColor = UIColor(named: "40")
            lbFavorite.textColor = UIColor(named: "173")
            viewLineJoined.backgroundColor = UIColor(named: "40")
            viewLineJoined.isHidden = false
            viewLineFavorite.isHidden = true
        } else if page == 1 {
            lbJoined.textColor = UIColor(named: "173")
            lbFavorite.textColor = UIColor(named: "40")
            viewLineFavorite.backgroundColor = UIColor(named: "40")
            viewLineJoined.isHidden = true
            viewLineFavorite.isHidden = false
        }
    }
        
    //MARK: - Selector Function
    @objc func pushView(_ notification: Notification) {
        if let studyId = notification.object {
            let vc = StudyDetailViewController(nibName: "StudyDetailViewController", bundle: nil)
            vc.studyId = Int(studyId as! Int)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // 검색 페이지로 이동
    @objc func btnSearchPressed(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - IBAction Function
    @IBAction func btnJoinBtnPressed(_ sender: Any) {
        currentPageHighLight(page: 0)
        guard let pageController = pageController else { return }
        pageController.setViewControllers([pageContent[0]], direction: .reverse, animated: true, completion: nil)

    }
    
    @IBAction func btnFavoriteBtnPressed(_ sender: Any) {
        currentPageHighLight(page: 1)
        guard let pageController = pageController else { return }
        pageController.setViewControllers([pageContent[1]], direction: .forward, animated: true, completion: nil)
    }
    
    
}
//MARK: - Extension

//MARK: UIPageViewController
extension StudyViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
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
            currentPageHighLight(page: index)
        }
    }
}
