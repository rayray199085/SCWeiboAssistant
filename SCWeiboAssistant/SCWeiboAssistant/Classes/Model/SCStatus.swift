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
    var id: Int64 = 0
    var text: String?
    
    
    override var description: String{
        return yy_modelDescription()
    }
}
