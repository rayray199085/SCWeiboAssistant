//
//  SCHomeViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import Alamofire

private let originalReuseIdentifier = "original_status_cell"
private let repostReuseIdentifier = "repost_status_cell"
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
        tableView?.register(UINib(nibName: "SCStatusTableViewNormalCell", bundle: nil), forCellReuseIdentifier: originalReuseIdentifier)
        tableView?.register(UINib(nibName: "SCStatusTableViewRepostCell", bundle: nil), forCellReuseIdentifier: repostReuseIdentifier)
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
        let statusViewModel = statusListViewModel.statusList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: statusViewModel.status.retweeted_status != nil ? repostReuseIdentifier : originalReuseIdentifier, for: indexPath) as! SCStatusTableViewCell
        cell.statusViewModel = statusViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let statusViewModel = statusListViewModel.statusList[indexPath.row]
        return statusViewModel.rowHeight
    }
}
