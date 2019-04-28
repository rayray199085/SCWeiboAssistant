//
//  SCStatusTableViewCell.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 27/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStatusTableViewCell: UITableViewCell {
    var statusViewModel: SCStatusViewModel?{
        didSet{
            detailsLabel.text = statusViewModel?.status.text
            screenNameLabel.text = statusViewModel?.status.user?.screen_name
            membershipImageView.image = statusViewModel?.membershipImage
            vipImageView.image = statusViewModel?.vipImage
            avatarImageView.setImage(
                urlString: statusViewModel?.status.user?.profile_image_url,
                backgroundColor: UIColor.white,
                placeholderImage:UIImage(named: "avatar_default_big"),
                isAvatar: true)
            toolBarView.statusViewModel = statusViewModel
        }
    }
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var membershipImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var toolBarView: SCCellToolBarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
