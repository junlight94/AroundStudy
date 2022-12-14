//  OpenStudyStep2ViewController.swift
//  AroundStudy
//
//  Created by coder3306 on 2022/11/18.
//  스터디 개설 2단계 뷰 컨트롤러

import UIKit

class OpenStudyStep2ViewController: BaseViewController {
    /// 스터디 2단계 컨텐츠 스크롤 뷰
    @IBOutlet weak var viewStudyStep2Content: UIScrollView?
    /// 스터디 이름 설정 뷰
    @IBOutlet weak var viewStudyName: UIView?
    /// 스터디 이름 입력 텍스트 필드
    @IBOutlet weak var tfStudyName: UITextField?
    /// 사진추가 버튼
    @IBOutlet weak var btnAddPhoto: UIButton?
    /// 사진추가 설명 뷰
    @IBOutlet weak var viewAddPhotoDesc: UIStackView?
    /// 스터디 소개 텍스트 뷰
    @IBOutlet weak var tvStudyAnnounce: UITextView?
    /// 스터디 소개 뷰
    @IBOutlet weak var viewStudyAnnounce: UIView?
    /// 다음단계 이동
    @IBOutlet weak var btnNext: UIButton?
    
    /// 스터디 소개 안내 텍스트
    private var textViewPlaceHolder = "스터디에 대해 소개해주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let targetScrollView = viewStudyStep2Content {
            setKeyboardNotification(targetView: targetScrollView)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotification()
    }
    
    /**
     * @네비게이션 바 초기화
     * @creator : coder3306
     */
    private func initNavigationBar() {
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "back"), for: .normal)
        back.addTarget(self, action: #selector(popToView(_:)), for: .touchUpInside)
        
        let naviItems = NavigationBarItems(title: "스터디 개설", leftBarButton: [back])
        setNavigationBar(naviItems: naviItems)
    }
    
    /**
     * @레이아웃 초기화
     * @creator : coder3306
     */
    private func initLayout() {
        viewStudyName?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnAddPhoto?.layer.setBorderLayout(radius: 8)
        viewStudyAnnounce?.layer.setBorderLayout(radius: 8, width: 1, color: UIColor(named: "236"))
        btnNext?.layer.setBorderLayout(radius: 8)
        tvStudyAnnounce?.text = textViewPlaceHolder
    }
}

//MARK: Action
extension OpenStudyStep2ViewController {
    /**
     * @사진 선택
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func choicePhoto(_ sender: UIButton) {
        //FIXME: - 사진추가 콜백 처리 --> 추가 시 기존의 +버튼, 라벨 뒤로보내기
    }
    
    /**
     * @스터디 개설 다음단계 이동
     * @creator : coder3306
     * @param sender : UIButton
     */
    @IBAction private func moveNextStep(_ sender: UIButton) {
        let step3 = OpenStudyStep3ViewController(nibName: "OpenStudyStep3ViewController", bundle: nil)
        self.navigationController?.pushViewController(step3, animated: true)
    }
}

//MARK: - UITextViewDelegate
extension OpenStudyStep2ViewController: UITextViewDelegate {
    /**
     * @텍스트뷰 편집 시작 전 기본 설정
     * @creator : coder3306
     */
    func textViewDidBeginEditing(_ textView: UITextView) {
        viewStudyStep2Content?.setContentOffset(CGPoint(x: 0, y: (viewStudyStep2Content?.contentSize.height ?? 0.0) - (viewStudyStep2Content?.bounds.height ?? 0.0) + 150), animated: true)
        if textView.text == textViewPlaceHolder {
            textView.text = nil
        }
    }
    
    /**
     * @텍스트뷰 편집 후 설정
     * @creator : coder3306
     */
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
        }
    }
}
