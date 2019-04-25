//
//  SCWelcomePageView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 25/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCWelcomePageView: UIView {
    class func welcomePageView()->SCWelcomePageView{
        let nib = UINib(nibName: "SCWelcomePageView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! SCWelcomePageView
        v.frame = UIScreen.main.bounds
        return v
    }
}
