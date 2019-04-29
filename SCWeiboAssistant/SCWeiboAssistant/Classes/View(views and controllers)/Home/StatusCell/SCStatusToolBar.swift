//
//  SCStatusToolBar.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 28/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStatusToolBar: UIView {
    var statusViewModel: SCStatusViewModel?{
        didSet{
           repostButton.setTitle(statusViewModel?.repostCount, for: [])
           commentButton.setTitle(statusViewModel?.commentCount, for: [])
           likeButton.setTitle(statusViewModel?.likeCount, for: [])
        }
    }
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
}
