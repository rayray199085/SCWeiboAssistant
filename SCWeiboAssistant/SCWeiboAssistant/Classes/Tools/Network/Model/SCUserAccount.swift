//
//  SCUserAccount.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 23/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCUserAccount: NSObject {
    @objc var access_token: String?
    @objc var uid: String?
    @objc var expires_in: TimeInterval = 0{
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    @objc var expiresDate: Date?
    override var description: String{
        return yy_modelDescription()
    }
}
