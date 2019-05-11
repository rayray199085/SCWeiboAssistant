//
//  SCComposeIdeaController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 6/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCComposeIdeaController: UIViewController {
    @IBOutlet var postButton: UIButton!
    @IBOutlet var titleView: SCComposeIdeaTitleView!
    
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var toolBar: UIToolbar!
    private lazy var placeholderLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addKeyboardWillChangeFrameNotification(selector: #selector(keyboardWillChangeFrame))
        textView.delegate = self
    }
    deinit {
        removeKeyboardWillChangeFrameNotification()
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    @objc private func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickPostButton(_ sender: Any) {
        guard let text = textView.text else{
            return 
        }
        SCNetworkManager.shared.postWeibo(text: text, image: nil) { (dict, isSuccess) in
            let message = isSuccess ? "Delivered" : "Fail to post"
            SVProgressHUD.showInfo(withStatus: message)
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
            if isSuccess{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    self.goBack()
                })
            }
        }
    }
    @objc private func clickToolBarButton(button: UIButton){
        switch button.tag {
            case 3:
                // switch keyboard
                print(button.tag)
            default:
                break
        }
    }
    @objc private func keyboardWillChangeFrame(notification: Notification){
        guard let (height,duration) = getKeyboardHeightAndAnimationDuration(notification: notification) else{
            return
        }
        toolBarBottomCons.constant = -height
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SCComposeIdeaController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        postButton.isEnabled = textView.hasText
        placeholderLabel.isHidden = textView.hasText
    }
}
private extension SCComposeIdeaController{
    func setupUI(){
        setupNavigationItem()
        setupPlaceholderLabel()
        setupToolBar()
    }
    
    func setupNavigationItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", fontSize: 16, target: self, action: #selector(goBack), isBack: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: postButton)
        navigationItem.titleView = titleView
        postButton.isEnabled = false
    }
    
    func setupPlaceholderLabel(){
        placeholderLabel.setPlaceholderLabel(textView: textView, placeholderString: "What's on your mind?")
        textView.addSubview(placeholderLabel)
    }
    
    func setupToolBar(){
        let toolBarButtonImages = [["image":"compose_toolbar_picture"],["image":"compose_mentionbutton_background"],["image":"compose_trendbutton_background"],["image":"compose_emoticonbutton_background"],["image":"compose_toolbar_more"]]
        var toolBarItems = [UIBarButtonItem]()
        for (index,dict) in toolBarButtonImages.enumerated(){
            guard let imageName = dict["image"] else {
                continue
            }
            let btn = UIButton.imageButton(withNormalImageName: imageName, andWithHighlightedImageName: "\(imageName)_highlighted")
            btn.addTarget(self, action: #selector(clickToolBarButton), for: UIControl.Event.touchUpInside)
            btn.tag = index
            toolBarItems.append(UIBarButtonItem(customView: btn))
            toolBarItems.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil))
        }
        toolBarItems.removeLast()
        toolBar.items = toolBarItems
    }
}
