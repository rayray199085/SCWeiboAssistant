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
}
