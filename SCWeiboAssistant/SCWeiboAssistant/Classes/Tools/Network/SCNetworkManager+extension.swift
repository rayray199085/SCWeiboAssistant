//
//  SCNetworkManager+extension.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 20/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire
// MARK: - network methods for sina weibo
extension SCNetworkManager{
    
    func getStatusList(since_id: Int64, max_id: Int64, completion:@escaping (_ list:[[String: Any]]?, _ isSuccess: Bool)->()){
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["since_id":"\(since_id)","max_id":"\(max_id > 0 ? (max_id - 1) : 0)"]
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: params) { (res, isSuccess) in
            let array = (res as? [String: Any])?["statuses"] as? [[String: Any]]
            completion(array,isSuccess)
        }
    }
    func getUnreadStatusCount(completion:@escaping (_ unreadStatusCount: Int)->()){
        guard let uid = userAccount.uid else {
            completion(0)
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["uid":uid]
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: params) { (res, isSuccess) in
            let unreadStatusCount = (res as? [String: Any])?["status"] as? Int
            completion(unreadStatusCount ?? 0)
        }
    }
    
    func getUserInfo(completion:@escaping (_ dict: [String: Any])->()){
        guard let uid = userAccount.uid else{
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = ["uid": uid]
        requestWithToken(urlString: urlString, method: HTTPMethod.get, params: params) { (res, isSuccess) in
            completion((res as? [String: Any]) ?? [:])
        }
    }
}
extension SCNetworkManager{
    func getAccessToken(code: String,completion:@escaping (_ isSuccess: Bool)->()){
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id": SCAppKey,
                      "client_secret": SCAppSecret,
                      "grant_type": "authorization_code",
                      "code":code,
                      "redirect_uri": SCRedirectURI]
        request(urlString: urlString, method: HTTPMethod.post, params: params) { (res, isSuccess, statusCode, error) in
            guard let tokenDict = res as? [String: Any] else{
                completion(false)
                return
            }
            self.userAccount.yy_modelSet(with: tokenDict)
            self.getUserInfo(completion: { (userInfoDict) in
                self.userAccount.yy_modelSet(with: userInfoDict)
                self.userAccount.saveUserInfo()
                completion(isSuccess)
            })
        }
    }
}
