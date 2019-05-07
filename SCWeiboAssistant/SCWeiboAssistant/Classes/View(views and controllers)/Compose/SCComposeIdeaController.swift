//
//  SCComposeIdeaController.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 6/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCComposeIdeaController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", fontSize: 16, target: self, action: #selector(goBack), isBack: true)
    }
    @objc private func goBack(){
        dismiss(animated: true, completion: nil)
    }
}
