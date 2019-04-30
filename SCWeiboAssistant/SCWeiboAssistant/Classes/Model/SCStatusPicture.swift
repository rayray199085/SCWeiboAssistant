//
//  SCStatusPicture.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 29/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStatusPicture: NSObject {
    @objc var thumbnail_pic: String?{
        didSet{
            let pic = thumbnail_pic ?? ""
            large_pic = (pic as NSString).replacingOccurrences(of: "thumbnail", with: "large")
        }
    }
    @objc var large_pic: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
