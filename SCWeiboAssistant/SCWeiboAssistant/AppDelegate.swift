//
//  AppDelegate.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupBasicSettings()
        requestAuthorization(application: application)
        window = UIWindow.initWindow(controllerName: "SCMainViewController")
        window?.backgroundColor = UIColor.white
        loadAppInfo()
        return true
    }
}
private extension AppDelegate{
    func loadAppInfo(){
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else{
                    return
            }
            try? data.write(to: URL(fileURLWithPath: NSString.getDocumentDirectory().appendingPathComponent("main.json")))
        }
    }
}
private extension AppDelegate{
    func setupBasicSettings(){
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
    func requestAuthorization(application: UIApplication){
        application.requestAuthorization { (isSuccess) in
            print("Request authorization \(isSuccess ? "successfully" : "failed")")
        }
    }
}
