//
//  TestViewController.swift
//  AroundStudy
//
//  Created by 박상현 on 2022/09/30.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var testThumbnailView: ThumbnailImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("테스트뷰컨")
        
        testThumbnailView.categoryTitle = "카테고리"
        testThumbnailView.image = "https://i.imgur.com/sduLRvf.jpeg"
        
        

        // Do any additional setup after loading the view.
    }


}
