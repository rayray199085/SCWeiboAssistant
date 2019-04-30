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
    var repostCount: String?
    var commentCount: String?
    var likeCount: String?
    var pictureViewSize = CGSize()
    var picUrls: [SCStatusPicture]?{
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    var repostDetails: String{
        return "@\(status.retweeted_status?.user?.screen_name ?? ""):\(status.retweeted_status?.text ?? "")"
    }
    
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
        repostCount = String.transformDigitsToString(count: status.reposts_count, defaultString: "repost")
        commentCount = String.transformDigitsToString(count: status.comments_count, defaultString: "comment")
        likeCount = String.transformDigitsToString(count: status.attitudes_count, defaultString: "like")
        pictureViewSize = calculatePictureViewSize(count: picUrls?.count)
    }
    
    func updatePictureViewWithSingleImage(image: UIImage?){
        guard let image = image else{
            return
        }
        var size = image.size
        if size.width > 300{
            let ratio: CGFloat = 200 / size.width
            size = CGSize(width: size.width * ratio, height: size.height * ratio)
        }
        if size.height > 300{
            let ratio: CGFloat = 300 / size.height
            size = CGSize(width: size.width * ratio, height: size.height * ratio)
        }
        size.height += SCStatusPictureViewOutterMargin
        pictureViewSize = size
    }
    
    private func calculatePictureViewSize(count: Int?)->CGSize{
        guard let count = count else{
            return CGSize(width: SCStatusPictureViewWidth, height: 0)
        }
        if count == 0{
            return CGSize(width: SCStatusPictureViewWidth, height: 0)
        }
        let row = CGFloat((count - 1) / 3 + 1)
        let height = SCStatusPictureViewOutterMargin + SCStatusPictureImageWidth * row + SCStatusPictureViewInnerMargin * (row - 1)
        return CGSize(width: SCStatusPictureViewWidth, height: height)
    }
    var description: String{
        return status.description
    }
}
