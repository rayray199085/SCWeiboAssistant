//
//  SCComposeTypeButton.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 5/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCComposeTypeButton: UIControl {
    var className: String?
    
    @IBOutlet weak var buttonImageView: UIImageView!
    @IBOutlet weak var buttonLabel: UILabel!
    class func composeTypeButton(imageName: String, labelText: String)-> SCComposeTypeButton{
        let nib = UINib(nibName: "SCComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil)[0] as! SCComposeTypeButton
        btn.buttonImageView.image = UIImage(named: imageName)
        btn.buttonLabel.text = labelText
        return btn
    }
}
