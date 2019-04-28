//
//  SCHomeViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "status_cell"
class SCHomeViewController: SCBaseViewController {
    private lazy var statusListViewModel = SCStatusListViewModel()
    
    @objc private func clickFriendButton(){
        navigationController?.pushViewController(SCDemoViewController(), animated: true)
    }
    override func loadData() {
        statusListViewModel.loadStatus(isPullUp: isPullUp) { (isSucces, shouldRefresh) in
            shouldRefresh ? self.tableView?.reloadData() : ()
            self.refreshControl?.endRefreshing()
            self.isPullUp = false
        }
    }
    @objc private func clickTitleButton(button: UIButton){
        button.isSelected = !button.isSelected
    }
}
extension SCHomeViewController{
    override func setupTableView() {
        super.setupTableView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            normalImageName: "navigationbar_friendsearch",
            highlightedImageName: "navigationbar_friendsearch_highlighted",
            target: self,
            action: #selector(clickFriendButton))
        tableView?.register(UINib(nibName: "SCStatusTableViewNormalCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 300
        tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        setupNavigationItemTitle()
    }
    
    private func setupNavigationItemTitle(){
        let titleButton = SCNavigationItemTitleButton(title: SCNetworkManager.shared.userAccount.screen_name)
        titleButton.addTarget(self, action: #selector(clickTitleButton), for: UIControl.Event.touchUpInside)
        navigationItem.titleView  = titleButton
    }
}
extension SCHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SCStatusTableViewCell
        cell.statusViewModel = statusListViewModel.statusList[indexPath.row]
        return cell
    }
}
