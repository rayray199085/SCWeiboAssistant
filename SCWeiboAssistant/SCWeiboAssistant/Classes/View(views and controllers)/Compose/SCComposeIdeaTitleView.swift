//
//  SCComposeIdeaTitleView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 10/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCComposeIdeaTitleView: UIView {

    @IBOutlet weak var screenName: UILabel!
    
    override func awakeFromNib() {
        screenName.text = SCNetworkManager.shared.userAccount.screen_name
    }
}
