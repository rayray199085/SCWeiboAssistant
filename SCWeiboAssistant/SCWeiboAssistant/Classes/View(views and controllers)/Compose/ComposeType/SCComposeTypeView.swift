//
//  SCComposeTypeView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 5/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
private let composeButtonWidth:CGFloat = 100
class SCComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeButton: UIButton!
    private let buttonsInfo = [["imageName":"tabbar_compose_idea","title":"Idea","clsName":"SCComposeIdeaViewController"],["imageName":"tabbar_compose_photo","title":"Photo"],["imageName":"tabbar_compose_weibo","title":"Weibo"],["imageName":"tabbar_compose_lbs","title":"Check-in"],["imageName":"tabbar_compose_review","title":"Comment"],["imageName":"tabbar_compose_more","title":"More"],["imageName":"tabbar_compose_friend","title":"Friends"],["imageName":"tabbar_compose_voice","title":"Voice"],["imageName":"tabbar_compose_music","title":"Music"],["imageName":"tabbar_compose_shooting","title":"Camera"]]
    
    class func composeTypeView()->SCComposeTypeView{
        let nib = UINib(nibName: "SCComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! SCComposeTypeView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    func show() {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.view.addSubview(self)
    }
    override func awakeFromNib() {
        setupUI()
    }
    
    @IBAction func clickCloseButton(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    @objc private func clickComposeButton(button: SCComposeTypeButton){
        print(button)
    }
}
    private extension SCComposeTypeView{
        func setupUI(){
            layoutIfNeeded()
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height))
            let rightView = UIView(frame: CGRect(x: UIScreen.screenWidth(), y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height))
            setupComposeButtons(range: NSRange(location: 0, length: 6), parentView: leftView)
            setupComposeButtons(range: NSRange(location: 6, length: 4), parentView: rightView)
            scrollView.contentSize = CGSize(width: UIScreen.screenWidth() * 2, height: 0)
        }
        
    private func setupComposeButtons(range: NSRange, parentView: UIView){
        let horizontalMargin = (UIScreen.screenWidth() - composeButtonWidth * 3) / 4
        let verticalMargin = (scrollView.bounds.height - composeButtonWidth * 2) / 3
       
        for index in range.location ..< range.location + range.length{
            let dict = buttonsInfo[index]
            guard let imageName = dict["imageName"],
                let title = dict["title"] else{
                    continue
            }
            var index = index
            index = index > 5 ? index - 6 : index
            let button = SCComposeTypeButton.composeTypeButton(imageName: imageName, labelText: title)
            let x = CGFloat(index % 3) * (composeButtonWidth + horizontalMargin) + horizontalMargin
            let y = CGFloat(index / 3) * (composeButtonWidth + verticalMargin) + verticalMargin
            button.frame = CGRect(x: x, y: y, width: composeButtonWidth, height: composeButtonWidth)
                parentView.addSubview(button)
        }
        scrollView.addSubview(parentView)
    }
}

