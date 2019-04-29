//
//  SCStatusPicture.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 29/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCStatusPicture: NSObject {
    @objc var thumbnail_pic: String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
