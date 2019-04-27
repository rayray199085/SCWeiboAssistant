//
//  SCStatusViewModel.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 27/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import YYModel

class SCStatusViewModel: CustomStringConvertible{
    var description: String{
        return status.description
    }
    
    var status: SCStatus
    
    init(model: SCStatus) {
        status = model
    }
}
