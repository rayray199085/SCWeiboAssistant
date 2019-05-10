//
//  WeiboCommon.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 22/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

let SCUserShouldLoginNotification = "SCUserShouldLoginNotification"
let SCUserSuccessLoginNotification = "SCUserSuccessLoginNotification"

let SCAppKey = "688141545"
let SCAppSecret = "72a8bc39b23d689acba994bf3f4ea160"
let SCRedirectURI = "http://baidu.com"
let SCSecurityDomain = "http://www.mob.com"

let SCStatusPictureViewOutterMargin: CGFloat = 12
let SCStatusPictureViewInnerMargin: CGFloat = 3
let SCStatusPictureViewWidth: CGFloat = UIScreen.screenWidth() - SCStatusPictureViewOutterMargin * 2
let SCStatusPictureImageWidth = (SCStatusPictureViewWidth - SCStatusPictureViewInnerMargin * 2) / 3
