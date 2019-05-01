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
    var rowHeight: CGFloat = 0
    
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
        updateRowHeight()
    }
    
    private func updateRowHeight(){
        let margin: CGFloat = 12
        let avatarViewHeight: CGFloat = 34
        let toolbarHeight: CGFloat = 35
        var height: CGFloat = 0
        let labelSize = CGSize(width: UIScreen.screenWidth() - 2 * margin,height: CGFloat(MAXFLOAT))
        let detailsString = status.text ?? ""
        let detailsFont = UIFont.systemFont(ofSize: 15)
        let repostDetailsFont = UIFont.systemFont(ofSize: 14)
        
        height += 2 * margin
        height += avatarViewHeight + margin
        height += detailsString.getTextHeight(size: labelSize, font: detailsFont)
        if status.retweeted_status != nil{
            height += 2 * margin
            height += repostDetails.getTextHeight(size: labelSize, font: repostDetailsFont)
        }
        height += pictureViewSize.height
        height += margin
        height += toolbarHeight
        rowHeight = height
    }
    
    func updatePictureViewWithSingleImage(image: UIImage?){
        guard let image = image else{
            return
        }
        let maxWidth: CGFloat = 200
        let maxHeight: CGFloat = 300
        var size = image.size
        if size.width > 300{
            let ratio: CGFloat = maxWidth / size.width
            size = CGSize(width: round(size.width * ratio), height: round(size.height * ratio))
        }
        if size.height > 300{
            let ratio: CGFloat = maxHeight / size.height
            size = CGSize(width: round(size.width * ratio), height: round(size.height * ratio))
        }
        size.height += SCStatusPictureViewOutterMargin
        pictureViewSize = size
        updateRowHeight()
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
