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
        print("click")
        navigationController?.pushViewController(SCDemoViewController(), animated: true)
    }
}
extension SCHomeViewController{
    override func setupUI() {
        super.setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Friends", target: self, action: #selector(clickFriendButton), isBack: false)
    }
}
