//
//  SCStatusPictureView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 29/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStatusPictureView: UIView {
    var picUrls: [SCStatusPicture]?{
        didSet{
            guard let pictures = picUrls else{
                return
            }
            for v in subviews{
                v.isHidden = true
            }
            var index = 0
            for pic in pictures {
                if index == 2 && pictures.count == 4{
                    index += 1
                }
                let iv = subviews[index] as! UIImageView
                iv.setImage(
                    urlString: pic.thumbnail_pic,
                    backgroundColor: UIColor.white,
                    placeholderImage: UIImage(named: "empty_picture"),
                    isAvatar: false)
                iv.isHidden = false
                index += 1
            }
        }
    }
    
    @IBOutlet weak var heightCons: NSLayoutConstraint!
    override func awakeFromNib() {
        setupUI()
    }
}
private extension SCStatusPictureView{
    func setupUI(){
        backgroundColor = superview?.backgroundColor
        clipsToBounds = true
        for i in 0..<9{
            let x = CGFloat(i % 3) * (SCStatusPictureImageWidth + SCStatusPictureViewInnerMargin)
            let y = SCStatusPictureViewOutterMargin + CGFloat(i / 3) * (SCStatusPictureImageWidth + SCStatusPictureViewInnerMargin)
            let imageView = UIImageView(frame: CGRect(x: x, y: y, width: SCStatusPictureImageWidth, height: SCStatusPictureImageWidth))
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            addSubview(imageView)
        }
    }
}
