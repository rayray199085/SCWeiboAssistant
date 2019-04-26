//
//  SCWelcomePageView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 25/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCWelcomePageView: UIView {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var imgBottomCons: NSLayoutConstraint!
    class func welcomePageView()->SCWelcomePageView{
        let nib = UINib(nibName: "SCWelcomePageView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! SCWelcomePageView
        v.frame = UIScreen.main.bounds
        return v
    }
    override func awakeFromNib() {
        avatarImageView.setImage(
            urlString: SCNetworkManager.shared.userAccount.avatar_large,
            backgroundColor: UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1),
            placeholderImage: UIImage(named: "avatar_default_big"),
            isAvatar: true,
            frameColor: UIColor.orange)
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layoutIfNeeded()
        imgBottomCons.constant = bounds.height - 200
        UIView.animate(
            withDuration: 1.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                self.layoutIfNeeded()
        },
            completion: { (_) in
                UIView.animate(withDuration: 1.0, animations: {
                    self.welcomeLabel.alpha = 1
                }, completion: { (_) in
                    self.removeFromSuperview()
                })
        })
    }
}
