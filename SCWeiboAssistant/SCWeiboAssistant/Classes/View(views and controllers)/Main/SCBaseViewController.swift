//
//  SCBaseViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - setup UI
extension SCBaseViewController{
    @objc func setupUI(){
        view.backgroundColor = UIColor.orange
    }
}
