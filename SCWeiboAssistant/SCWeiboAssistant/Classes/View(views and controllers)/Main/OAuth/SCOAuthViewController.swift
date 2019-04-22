//
//  SCOAuthViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 22/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import WebKit

class SCOAuthViewController: UIViewController {
    private lazy var webView = WKWebView(frame: UIScreen.main.bounds)
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        title = "Sina Weibo Login"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", fontSize: 16, target: self, action: #selector(goBack), isBack: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc private func goBack(){
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
