//
//  SCCellToolBarView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 28/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCCellToolBarView: UIView {
    var statusViewModel: SCStatusViewModel?{
        didSet{
            let repostCount = statusViewModel?.repostCount ?? 0
            repostButton.setTitle("\(repostCount)", for: [])
        }
    }
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
}
