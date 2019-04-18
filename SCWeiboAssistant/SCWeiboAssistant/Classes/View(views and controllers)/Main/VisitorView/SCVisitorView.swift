//
//  SCVisitorView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 18/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCVisitorView: UIView {
    var visitorInfo: [String : String]?{
        didSet{
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            descriptionLabel.text = message
//          empty string means first page, no need to set image
            if imageName == ""{
                return
            }
            houseImageView.image = UIImage(named: imageName)
            wheelImageView.isHidden = true
            wheelMaskImageView.isHidden = true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var wheelImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private lazy var wheelMaskImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    private lazy var houseImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_image_house"))
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(
            text: "It's free and always will be.",
            andWithFontSize: 14,
            andColor: UIColor.darkGray)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
       let button = UIButton.textButton(
            withTitle: "Sign Up",
            andWithFontSize: 16,
            andWithNormalColor: UIColor.orange,
            andWithHighlight: UIColor.black,
            andWithBackgroundImageName: "common_button_white")
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton.textButton(
            withTitle: "Login",
            andWithFontSize: 16,
            andWithNormalColor: UIColor.darkGray,
            andWithHighlight: UIColor.black,
            andWithBackgroundImageName: "common_button_white")
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        return button
    }()
}
extension SCVisitorView{
    func setupUI() {
        backgroundColor = UIColor.init(displayP3Red: 237.0/255, green: 237.0/255, blue: 237.0/255, alpha: 1.0)
        
        addSubview(wheelImageView)
        addSubview(wheelMaskImageView)
        addSubview(houseImageView)
        addSubview(descriptionLabel)
        addSubview(signUpButton)
        addSubview(loginButton)
        
        for v in subviews{
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        let margin: CGFloat = 20
        
        addConstraint(NSLayoutConstraint(
            item: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1.0, constant: -60))
        
        addConstraint(NSLayoutConstraint(
            item: houseImageView,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: houseImageView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.centerY,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: descriptionLabel,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.centerX,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: descriptionLabel,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1.0,
            constant: margin))
        
        addConstraint(NSLayoutConstraint(
            item: descriptionLabel,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute,
            multiplier: 1, constant: UIScreen.screenWidth() - margin))
        
        addConstraint(NSLayoutConstraint(
            item: signUpButton,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: descriptionLabel,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1.0, constant: margin))
        
        addConstraint(NSLayoutConstraint(
            item: signUpButton,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.left,
            multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: loginButton,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: signUpButton,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: loginButton,
            attribute: NSLayoutConstraint.Attribute.centerX,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.right,
            multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: loginButton,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: signUpButton,
            attribute: NSLayoutConstraint.Attribute.width,
            multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: wheelMaskImageView,
            attribute: NSLayoutConstraint.Attribute.bottom,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.bottom,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: wheelMaskImageView,
            attribute: NSLayoutConstraint.Attribute.left,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.left,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: wheelMaskImageView,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: self,
            attribute: NSLayoutConstraint.Attribute.width,
            multiplier: 1.0,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: wheelMaskImageView,
            attribute: NSLayoutConstraint.Attribute.top,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: wheelImageView,
            attribute: NSLayoutConstraint.Attribute.top,
            multiplier: 1.0,
            constant: 0))
        
//        let anim = CABasicAnimation(keyPath: "transform.rotation")
//        anim.toValue = Double.pi * 2
//        anim.repeatCount = MAXFLOAT
//        anim.duration = 60
//        anim.isRemovedOnCompletion = false
//        wheelImageView.layer.add(anim, forKey: nil)
    }
}
