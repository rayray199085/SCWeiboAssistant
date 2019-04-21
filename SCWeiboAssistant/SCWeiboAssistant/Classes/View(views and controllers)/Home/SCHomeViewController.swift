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
}
extension SCHomeViewController{
    override func setupTableView() {
        super.setupTableView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            normalImageName: "navigationbar_friendsearch",
            highlightedImageName: "navigationbar_friendsearch_highlighted",
            target: self,
            action: #selector(clickFriendButton))
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SCHomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = statusListViewModel.statusList[indexPath.row].text
        return cell
    }
}
