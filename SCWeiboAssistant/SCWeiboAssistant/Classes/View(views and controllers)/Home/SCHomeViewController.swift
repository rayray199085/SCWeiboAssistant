//
//  SCHomeViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCHomeViewController: SCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc private func clickFriendButton(){
        navigationController?.pushViewController(SCDemoViewController(), animated: true)
    }
}
extension SCHomeViewController{
    override func setupUI() {
        super.setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(normalImageName: "navigationbar_friendsearch", highlightedImageName: "navigationbar_friendsearch_highlighted", target: self, action: #selector(clickFriendButton))
    }
}
