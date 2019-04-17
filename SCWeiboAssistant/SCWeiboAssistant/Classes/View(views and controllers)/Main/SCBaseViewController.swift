//
//  SCBaseViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCBaseViewController: UIViewController {
    var tableView: UITableView?
    var refreshControl: UIRefreshControl?
    var isPullUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    @objc func loadData(){
        refreshControl?.endRefreshing()
    }
}

// MARK: - setup UI
extension SCBaseViewController{
    @objc func setupUI(){
//        view.backgroundColor = UIColor.orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        setupTableView()
    }
    
    private func setupTableView(){
        tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        guard let tableView = tableView,
        let naviBar = navigationController?.navigationBar else {
            return
        }
        view.insertSubview(tableView, belowSubview: naviBar)
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl!)
        refreshControl?.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
    }
}
extension SCBaseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        let currentSection = indexPath.section
        let lastSection = tableView.numberOfSections - 1
        if currentSection == lastSection && (currentRow == tableView.numberOfRows(inSection: lastSection) - 1) && !isPullUp {
            isPullUp = true
            loadData()
        }
        
    }
}
