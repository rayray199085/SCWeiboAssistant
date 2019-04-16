//
//  SCDemoViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 16/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCDemoViewController: SCBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Number: \(navigationController?.children.count ?? 0)"
    }
    @objc private func clickNextButton(){
        navigationController?.pushViewController(SCDemoViewController(), animated: true)
        
    }
}
extension SCDemoViewController{
    override func setupUI() {
        super.setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", target: self, action: #selector(clickNextButton), isBack: false)
    }
}
