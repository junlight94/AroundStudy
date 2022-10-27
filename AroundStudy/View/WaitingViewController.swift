//
//  WaitingViewController.swift
//  AroundStudy
//
//  Created by Junyoung on 2022/10/27.
//

import UIKit

class WaitingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChattingListTableViewCell", bundle: nil), forCellReuseIdentifier: "ChattingListTableViewCell")
    }
}
extension WaitingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChattingListTableViewCell", for: indexPath) as! ChattingListTableViewCell
        
        return cell
    }
}
