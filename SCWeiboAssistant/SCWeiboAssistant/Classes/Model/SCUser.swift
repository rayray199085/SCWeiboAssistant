//
//  SCUser.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 27/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCUser: NSObject {
    @objc var id: Int64 = 0
    @objc var screen_name: String?
    @objc var profile_image_url: String?
    @objc var verified_type:Int = 0
    @objc var mbrank: Int = 0
    
    override var description: String{
        return yy_modelDescription()
    }
}
