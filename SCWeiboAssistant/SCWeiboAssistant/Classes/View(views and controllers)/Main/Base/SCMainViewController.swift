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
        let array = [
            ["clsName":"SCHomeViewController", "title":"Home", "imageName":"home"],
            ["clsName":"SCMessageViewController", "title":"Message", "imageName":"message_center"],
            ["clsName":"UIViewController"],
            ["clsName":"SCDiscoverViewController", "title":"Discover", "imageName":"discover"],
            ["clsName":"SCProfileViewController", "title":"Profile", "imageName":"profile"]]
        var controllers = [UIViewController]()
        for dict in array{
            controllers.append(getController(dictionary: dict))
        }
        viewControllers = controllers
    }
    
    /// Use dictionary to create a controller
    ///
    /// - Parameter dict: dictionary
    /// - Returns: view controller
    func getController(dictionary dict:[String: String])->UIViewController{
        guard let clsName = dict["clsName"],
        let title = dict["title"],
        let imageName = dict["imageName"],
        let cls = NSClassFromString("\(Bundle.main.nameSpace)." + clsName) as? UIViewController.Type else {
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
