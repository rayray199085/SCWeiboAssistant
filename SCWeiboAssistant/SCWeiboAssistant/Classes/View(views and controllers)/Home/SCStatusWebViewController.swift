//
//  SCStatusWebViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 9/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SCStatusWebViewController: SCBaseViewController {
    private lazy var webView: WKWebView = WKWebView(frame: UIScreen.main.bounds)
    var urlString: String?{
        didSet{
            guard let urlString = urlString,
                  let url = URL(string: urlString) else{
                return
            }
            webView.load(URLRequest(url: url))
        }
    }
}
extension SCStatusWebViewController{
    override func setupTableView() {
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        view.addSubview(webView)
        navigationItem.title = "Web Page"
    }
}
extension SCStatusWebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}
