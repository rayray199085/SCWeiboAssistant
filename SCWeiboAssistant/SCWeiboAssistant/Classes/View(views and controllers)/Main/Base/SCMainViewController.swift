//
//  SCMainViewController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 15/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCMainViewController: UITabBarController {
    private lazy var composeButton: UIButton = UIButton.imageButton(
        withImageName: "tabbar_compose_icon_add",
        andBackgroundImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupComposeButton()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    // FIXME: compose button observer
    @objc private func clickComposeButton(){
        print("click")
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
            controllers.append(getController(dictionary: dict))
        }
        viewControllers = controllers
        (array as NSArray).write(toFile: "/Users/stephencao/Desktop/weibo.plist", atomically: true)
    }
    
    /// Use dictionary to create a controller
    ///
    /// - Parameter dict: dictionary
    /// - Returns: view controller
    func getController(dictionary dict:[String: Any])->UIViewController{
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
        let itemWidth = tabBar.bounds.width / CGFloat(children.count) - 1
        composeButton.frame = tabBar.bounds.insetBy(dx: itemWidth * 2, dy: 0)
        composeButton.addTarget(self, action: #selector(clickComposeButton), for: UIControl.Event.touchUpInside)
    }
}
