//
//  SCOAuthViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 22/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class SCOAuthViewController: UIViewController {
    private lazy var webView = WKWebView(frame: UIScreen.main.bounds)
    override func loadView() {
        view = webView
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        view.backgroundColor = UIColor.white
        title = "Sina Weibo Login"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", fontSize: 16, target: self, action: #selector(goBack), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AutoFill", fontSize: 16, target: self, action: #selector(AutoFill), isBack: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(SCAppKey        )&redirect_uri=\(SCRedirectURI)"
        guard let url = URL(string: urlString) else{
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    @objc private func goBack(){
        SVProgressHUD.dismiss()
        navigationController?.dismiss(animated: true, completion: nil)
    }
    @objc private func AutoFill(){
        webView.autoFillUsernameAndPassword(username: "0061450231088", password: "Myd900524")
    }
}
extension SCOAuthViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString.hasPrefix(SCRedirectURI) == false {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        if navigationAction.request.url?.query?.hasPrefix("code=") == false{
            decisionHandler(WKNavigationActionPolicy.cancel)
            goBack()
            return
        }
        let code = ((navigationAction.request.url?.query)! as NSString).substring(from: "code=".count)
        SCNetworkManager.shared.getAccessToken(code: code) { (isSuccess) in
            if !isSuccess{
                SVProgressHUD.showInfo(withStatus: "Can not connect to the Internet.")
            }else{
                NotificationCenter.default.post(name: NSNotification.Name(SCUserSuccessLoginNotification), object: nil)
                self.goBack()
            }
        }
        decisionHandler(WKNavigationActionPolicy.cancel)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}
