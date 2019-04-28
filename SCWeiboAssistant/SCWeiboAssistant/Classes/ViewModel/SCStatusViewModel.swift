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
    var status: SCStatus
    
    var membershipImage: UIImage?
    var vipImage: UIImage?
    var repostCount: Int = 0
    
    init(model: SCStatus) {
        status = model
        let mbrank = status.user?.mbrank ?? 0
        membershipImage = (mbrank > 0 && mbrank <= 7) ? UIImage(named: "common_icon_membership_level\(mbrank)") : nil
        switch (status.user?.verified_type ?? -1) {
            case -1:
                vipImage = nil
            case 0:
                vipImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                vipImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                vipImage = UIImage(named: "avatar_grassroot")
            default:
                break
        }
        repostCount = status.reposts_count
    }
    var description: String{
        return status.description
    }
}
