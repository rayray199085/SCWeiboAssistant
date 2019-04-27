//
//  SCStatus.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 20/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import YYModel
class SCStatus: NSObject {
    @objc var id: Int64 = 0
    @objc var text: String?
    @objc var user: SCUser?
    override var description: String{
        return yy_modelDescription()
    }
}
