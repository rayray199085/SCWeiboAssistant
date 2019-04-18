//
//  SCVisitorView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 18/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCVisitorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var wheelImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    private lazy var houseImageView: UIImageView = UIImageView(
        image: UIImage(named: "visitordiscover_feed_image_house"))
    private lazy var descriptionLabel: UILabel = UILabel(
        text: "It's free and always will be.",
        andWithFontSize: 14,
        andColor: UIColor.darkGray)
    private lazy var signUpButton: UIButton = UIButton.textButton(
        withTitle: "Sign Up",
        andWithFontSize: 16,
        andWithNormalColor: UIColor.orange,
        andWithHighlight: UIColor.black)
    private lazy var loginButton: UIButton = UIButton.textButton(
        withTitle: "Login",
        andWithFontSize: 16,
        andWithNormalColor: UIColor.darkGray,
        andWithHighlight: UIColor.black)
}
extension SCVisitorView{
    func setupUI() {
        addSubview(wheelImageView)
        addSubview(houseImageView)
        addSubview(descriptionLabel)
        addSubview(signUpButton)
        addSubview(loginButton)
        
        for v in subviews{
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
        
//        let anim = CABasicAnimation(keyPath: "transform.rotation")
//        anim.toValue = Double.pi * 2
//        anim.repeatCount = MAXFLOAT
//        anim.duration = 60
//        anim.isRemovedOnCompletion = false
//        wheelImageView.layer.add(anim, forKey: nil)
    }
}
