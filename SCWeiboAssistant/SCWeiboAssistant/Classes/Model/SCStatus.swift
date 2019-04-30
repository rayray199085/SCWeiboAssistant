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
    @objc var reposts_count: Int = 0
    @objc var comments_count: Int = 0
    @objc var attitudes_count: Int = 0
    @objc var pic_urls: [SCStatusPicture]?
    @objc var retweeted_status: SCStatus?
    
    override var description: String{
        return yy_modelDescription()
    }
    @objc class func modelContainerPropertyGenericClass()->[String:AnyClass]{
        return ["pic_urls": SCStatusPicture.self]
    }
}
