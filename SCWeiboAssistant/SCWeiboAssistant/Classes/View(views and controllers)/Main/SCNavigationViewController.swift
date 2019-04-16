//
//  SCINavigationViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCNavigationViewController: UINavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0{
             viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
