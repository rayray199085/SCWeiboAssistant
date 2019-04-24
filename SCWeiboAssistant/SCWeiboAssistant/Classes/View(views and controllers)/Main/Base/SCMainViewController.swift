//
//  SCMainViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import SVProgressHUD

class SCMainViewController: UITabBarController {
    private var timer: Timer?
    private lazy var composeButton: UIButton = UIButton.imageButton(
        withImageName: "tabbar_compose_icon_add",
        andBackgroundImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupComposeButton()
        setupTimer()
        delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(handleLoginNotification), name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
        
    }
    @objc private func handleLoginNotification(notification: Notification){
        var delay = DispatchTime.now()
        if (notification.object as? String) == "invalid token"{
            delay = DispatchTime.now() + 1.0
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.gradient)
            SVProgressHUD.showInfo(withStatus: "Invalid Token")
        }
        let nav = UINavigationController(rootViewController: SCOAuthViewController())
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.present(nav, animated: true, completion: nil)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self
            , name: NSNotification.Name(SCUserShouldLoginNotification), object: nil)
        timer?.invalidate()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    // FIXME: compose button observer
    @objc private func clickComposeButton(){
        print("click")
    }
}
extension SCMainViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !SCNetworkManager.shared.userLogon{
            return true
        }
        let index = children.firstIndex(of: viewController) ?? 0
        if selectedViewController == viewController && index == 0{
            let vc = viewController.children[0] as! SCHomeViewController
            let offset = vc.navigationController?.navigationBar.frame.maxY ?? 64
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -offset), animated: true)
            vc.loadData()
            tabBar.items?[0].badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        return !viewController.isMember(of: UIViewController.self)
    }
}
private extension SCMainViewController{
    func setupTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true, block: { (timer) in
            if !SCNetworkManager.shared.userLogon{
                return
            }
            SCNetworkManager.shared.getUnreadStatusCount { (unreadStatusCount) in
                self.tabBar.items?[0].badgeValue = unreadStatusCount > 0 ? "\(unreadStatusCount)" : nil
                UIApplication.shared.applicationIconBadgeNumber = unreadStatusCount
            }
        })
    }
}
private extension SCMainViewController{
    
    /// setup child controllers
    /**
     tab bar con - > nav con -> base con
     */
    func setupChildControllers(){
        // load data from document file
        let networkData = try? Data(contentsOf: URL(fileURLWithPath: NSString.getDocumentDirectory().appendingPathComponent("main.json")))
         
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
            let data = (networkData != nil) ? networkData : try? Data(contentsOf: URL(fileURLWithPath: path)),
            let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else{
                return
        }
        var controllers = [UIViewController]()
        for dict in array{
            controllers.append(getController(dict: dict))
        }
        viewControllers = controllers
        (array as NSArray).write(toFile: "/Users/stephencao/Desktop/weibo.plist", atomically: true)
    }
    
    /// Use dictionary to create a controller
    ///
    /// - Parameter dict: dictionary
    /// - Returns: view controller
    func getController(dict:[String: Any])->UIViewController{
        guard let clsName = dict["clsName"] as? String,
        let title = dict["title"] as? String,
        let imageName = dict["imageName"] as? String,
        let cls = NSClassFromString("\(Bundle.main.nameSpace)." + clsName) as? SCBaseViewController.Type,
        let visitorInfo = dict["visitorInfo"] as? [String: String] else {
            return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        let normalImageName = "tabbar_\(imageName)"
        vc.tabBarItem.image = UIImage(named: normalImageName)
        vc.tabBarItem.selectedImage = UIImage(
            named: normalImageName + "_selected")?.withRenderingMode(
                UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor : UIColor.orange],
            for: UIControl.State.highlighted)
        vc.visitorInfo = visitorInfo
        let navigationController = SCNavigationViewController(rootViewController: vc)
        return navigationController
    }
    
    /// setup compose button
    func setupComposeButton(){
        tabBar.addSubview(composeButton)
        // calculate button location
        let itemWidth = tabBar.bounds.width / CGFloat(children.count)
        composeButton.frame = tabBar.bounds.insetBy(dx: itemWidth * 2, dy: 0)
        composeButton.addTarget(self, action: #selector(clickComposeButton), for: UIControl.Event.touchUpInside)
    }
}
