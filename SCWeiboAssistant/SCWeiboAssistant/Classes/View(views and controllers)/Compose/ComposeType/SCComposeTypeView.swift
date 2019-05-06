//
//  SCComposeTypeView.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 5/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import pop

private let composeButtonWidth:CGFloat = 100
class SCComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!
    @IBOutlet weak var prevButtonCenterXCons: NSLayoutConstraint!
    private let buttonsInfo = [["imageName":"tabbar_compose_idea","title":"Idea","clsName":"SCComposeIdeaController"],["imageName":"tabbar_compose_photo","title":"Photo"],["imageName":"tabbar_compose_weibo","title":"Weibo"],["imageName":"tabbar_compose_lbs","title":"Check-in"],["imageName":"tabbar_compose_review","title":"Comment"],["imageName":"tabbar_compose_more","title":"More", "actionName":"clickMore"],["imageName":"tabbar_compose_friend","title":"Friends"],["imageName":"tabbar_compose_voice","title":"Voice"],["imageName":"tabbar_compose_music","title":"Music"],["imageName":"tabbar_compose_shooting","title":"Camera"]]
    
    class func composeTypeView()->SCComposeTypeView{
        let nib = UINib(nibName: "SCComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! SCComposeTypeView
        v.frame = UIScreen.main.bounds
        v.setupUI()
        return v
    }
    
    func show() {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.view.addSubview(self)
        showViewWithAnimation()
    }
   
    @IBAction func clickCloseButton(_ sender: UIButton) {
        dismissButtons()
    }
    
    @IBAction func clickPrevButton(_ sender: Any) {
        prevButtonCenterXCons.constant += UIScreen.screenWidth() / 6
        closeButtonCenterXCons.constant -= UIScreen.screenWidth() / 6
        scrollView.setContentOffset(CGPoint.zero, animated: true)
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            self.prevButton.alpha = 0
        }) { (_) in
            self.prevButton.isHidden = true
        }
    }
    
    
    @objc private func clickMore(){
        scrollView.setContentOffset(CGPoint(x: UIScreen.screenWidth(), y: 0), animated: true)
        closeButtonCenterXCons.constant += UIScreen.screenWidth() / 6
        prevButton.isHidden = false
        prevButtonCenterXCons.constant -= UIScreen.screenWidth() / 6
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
            self.prevButton.alpha = 1
        }
    }
    
    @objc private func clickComposeButton(button: SCComposeTypeButton){
        guard let clsName = button.className else{
            return
        }
        print(clsName)
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
        
    func setupComposeButtons(range: NSRange, parentView: UIView){
        let horizontalMargin = (UIScreen.screenWidth() - composeButtonWidth * 3) / 4
        let verticalMargin = scrollView.bounds.height - composeButtonWidth * 2
       
        for index in range.location ..< range.location + range.length{
            let dict = buttonsInfo[index]
            guard let imageName = dict["imageName"],
                let title = dict["title"] else{
                    continue
            }
            let button = SCComposeTypeButton.composeTypeButton(imageName: imageName, labelText: title)
            var index = index
            index = index > 5 ? index - 6 : index
            let x = CGFloat(index % 3) * (composeButtonWidth + horizontalMargin) + horizontalMargin
            let y = index > 2 ? composeButtonWidth + verticalMargin : 0
            button.frame = CGRect(x: x, y: y, width: composeButtonWidth, height: composeButtonWidth)
            if let actionName = dict["actionName"]{
                button.addTarget(self, action: Selector(actionName), for: UIControl.Event.touchUpInside)
            }else{
                button.addTarget(self, action: #selector(clickComposeButton), for: UIControl.Event.touchUpInside)
            }
            button.className = dict["clsName"]
            parentView.addSubview(button)
            
        }
        scrollView.addSubview(parentView)
    }
}

private extension SCComposeTypeView{
    func showViewWithAnimation(){
        addPopAlphaAnimation(fromValue: 0, toValue: 1.0, duration: 0.25)
        showComposeTypeButtons()
    }
    func showComposeTypeButtons(){
        scrollView.clipsToBounds = false
        let leftView = scrollView.subviews[0]
        for (index,btn) in leftView.subviews.enumerated(){
            btn.addPopVerticalAnimation(
                fromValue: btn.center.y + 400,
                toValue: btn.center.y,
                springBounciness: 8,
                delay:Double(index) * 0.025)
        }
    }
    
    func dismissButtons(){
        let currentPage = Int(scrollView.contentOffset.x / UIScreen.screenWidth())
        let currentSubView = scrollView.subviews[currentPage]
        for (index,btn) in currentSubView.subviews.enumerated().reversed(){
            btn.addPopVerticalAnimation(
                fromValue: btn.center.y,
                toValue: btn.center.y + 400,
                springBounciness: 8,
                delay: Double(currentSubView.subviews.count - index) * 0.025) { (_, _) in
                    if index == 0{
                        self.addPopAlphaAnimation(
                            fromValue: 1.0,
                            toValue: 0,
                            duration: 0.25,
                            completionBlock: { (_, _) in
                                self.removeFromSuperview()
                        })
                    }
            }
        }
        
    }
}

