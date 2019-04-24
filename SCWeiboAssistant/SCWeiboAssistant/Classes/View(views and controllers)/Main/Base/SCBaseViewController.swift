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
    var visitorInfo : [String : String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        SCNetworkManager.shared.userLogon ? loadData() :()
        NotificationCenter.default.addObserver(self, selector: #selector(successLogin), name: NSNotification.Name(SCUserSuccessLoginNotification), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(SCUserSuccessLoginNotification), object: self)
    }
    @objc func loadData(){
        refreshControl?.endRefreshing()
    }
}
extension SCBaseViewController{
    @objc private func signUp(){
        print("signUp")
    }
    
    @objc private func login(){
        NotificationCenter.default.post(name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
    }
    @objc private func successLogin(){
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        view = nil
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(SCUserSuccessLoginNotification), object: nil)
    }
}

// MARK: - setup UI
extension SCBaseViewController{
    @objc private func setupUI(){
//        view.backgroundColor = UIColor.orange
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        SCNetworkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    @objc func setupTableView(){
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
    
    private func setupVisitorView(){
        let visitiorView = SCVisitorView(frame: view.bounds)
        visitiorView.visitorInfo = visitorInfo
        guard let naviBar = navigationController?.navigationBar else {
                return
        }
        visitiorView.signUpButton.addTarget(self, action: #selector(signUp), for: UIControl.Event.touchUpInside)
        visitiorView.loginButton.addTarget(self, action: #selector(login), for: UIControl.Event.touchUpInside)
        view.insertSubview(visitiorView, belowSubview: naviBar)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Up", style: UIBarButtonItem.Style.plain, target: self, action: #selector(signUp))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Login", style: UIBarButtonItem.Style.plain, target: self, action: #selector(login))
        naviBar.tintColor = UIColor.orange
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
