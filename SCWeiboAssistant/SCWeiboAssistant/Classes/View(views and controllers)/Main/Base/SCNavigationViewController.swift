//
//  SCINavigationViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        allowSwipeToGoBack()
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0{
             viewController.hidesBottomBarWhenPushed = true
            let leftBarButtonItem = children.count == 1 ? (children[0].title ?? "Back") : "Back"
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: leftBarButtonItem,
                fontSize: 16,
                target: self,
                action: #selector(goBack),
                isBack: true)
        }
        super.pushViewController(viewController, animated: animated)
    }
    @objc private func goBack(){
        popViewController(animated: true)
    }
}


