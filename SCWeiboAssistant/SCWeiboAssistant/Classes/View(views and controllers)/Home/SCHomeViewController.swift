//
//  SCHomeViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
private let reuseIdentifier = "status_cell"
class SCHomeViewController: SCBaseViewController {
    private lazy var statusList = [String]()
    
    @objc private func clickFriendButton(){
        navigationController?.pushViewController(SCDemoViewController(), animated: true)
    }
    override func loadData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            for i in 0..<30 {
                if self.isPullUp{
                    self.statusList.append("up -- status\(i)")
                }else{
                    self.statusList.insert("down *** status\(i)", at: 0)
                }
            }
            self.tableView?.reloadData()
            self.refreshControl?.endRefreshing()
            self.isPullUp = false
        }
    }
}
extension SCHomeViewController{
    override func setupUI() {
        super.setupUI()
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
        return statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
    }
}
