//
//  SCNavigationItemTitleButton.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 25/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCNavigationItemTitleButton: UIButton {
    init(title: String?){
        super.init(frame: CGRect())
        setupUI(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        guard let titleLabel = titleLabel,
//              let imageView = imageView else {
//            return
//        }
//        titleLabel.frame =  titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
//        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width , dy: 0)
        titleLabel?.frame = CGRect(
            x: 0,
            y: titleLabel?.frame.origin.y ?? 0,
            width: titleLabel?.bounds.width ?? 0,
            height: titleLabel?.bounds.height ?? 0)
        imageView?.frame = CGRect(
            x: titleLabel?.bounds.width ?? 0,
            y: imageView?.frame.origin.y ?? 0,
            width: imageView?.bounds.width ?? 0,
            height: imageView?.bounds.height ?? 0)
    }
}
extension SCNavigationItemTitleButton{
    func setupUI(title: String?){
        if title == nil{
            setTitle("Home", for: [])
        }else{
            setTitle("\(title!) ", for: [])
            setImage(UIImage(named: "navigationbar_arrow_down"), for: [])
            setImage(UIImage(named: "navigationbar_arrow_up"), for: UIControl.State.selected)
        }
        setTitleColor(UIColor.darkGray, for: [])
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        adjustsImageWhenHighlighted = false
        sizeToFit()
    }
}
