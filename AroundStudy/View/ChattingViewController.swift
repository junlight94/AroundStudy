//
//  ChattingViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/01.
//

import UIKit

class ChattingViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var viewProgressLine: UIView!
    
    @IBOutlet weak var lbWaiting: UILabel!
    @IBOutlet weak var viewWaitingLine: UIView!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewContentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var viewSearchHeight: NSLayoutConstraint!
    
    
    var pageController: UIPageViewController?
    
    // true: 채팅, false: 검색
    var contentMode = true
    
    lazy var pageContent = [ProgressViewController(nibName: "ProgressViewController", bundle: nil),
                            WaitingViewController(nibName: "WaitingViewController", bundle: nil)]
    
    //MARK: - Override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    

    //MARK: - General Function
    func setupView(){
        //Navigation
        let btnSearch = UIButton()
        btnSearch.setImage(UIImage(named: "search"), for: .normal)
        btnSearch.addTarget(self, action: #selector(btnSearchPressed), for: .touchUpInside)
        setNavigationBar("채팅", leftBarButton: nil, rightBarButton: [btnSearch], isLeftSetting: true)
        
        //UIPageViewController
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        guard let pageController = pageController else { return }
        pageController.delegate = self
        pageController.dataSource = self
        pageController.setViewControllers([pageContent.first!], direction: .forward, animated: true, completion: nil)
        
        viewContent.addSubview(pageController.view)
        let pageViewRect = viewContent.bounds
        
        pageController.view.frame = pageViewRect
        pageController.didMove(toParent: self)
        
        //Mode
        viewSearch.isHidden = true
        let viewHeight = self.view.frame.height - 98
        viewContentHeight.constant = viewHeight
        viewSearchHeight.constant = viewHeight
    }
    
    func updateView() {
        if contentMode == true {
            viewContent.isHidden = false
            viewSearch.isHidden = true
        } else {
            viewContent.isHidden = true
            viewSearch.isHidden = false
        }
    }
    
    func pageChanged(page: Int) {
        switch page {
        case 0 :
            lbProgress.textColor = UIColor(named: "40")
            viewProgressLine.isHidden = false
            lbWaiting.textColor = UIColor(named: "173")
            viewWaitingLine.isHidden = true
        case 1 :
            lbProgress.textColor = UIColor(named: "173")
            viewProgressLine.isHidden = true
            lbWaiting.textColor = UIColor(named: "40")
            viewWaitingLine.isHidden = false
        default:
            break
        }
    }
        
    //MARK: - Selector Function
    // btnSearch
    @objc func btnSearchPressed(_ sender: UIButton) {
        print(#function)
        contentMode = false
        updateView()
    }
    
        
    //MARK: - IBAction Function
    @IBAction func btnPageChangePressed(_ sender: UIButton) {
        pageChanged(page: sender.tag)
        guard let pageController = pageController else { return }
        if sender.tag == 0 {
            pageController.setViewControllers([pageContent[sender.tag]], direction: .reverse, animated: true, completion: nil)
        } else {
            pageController.setViewControllers([pageContent[sender.tag]], direction: .forward, animated: true, completion: nil)
        }
    }
}
//MARK: - Extension
//MARK: UIPageViewController
extension ChattingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
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
            pageChanged(page: index)
        }
    }
}
