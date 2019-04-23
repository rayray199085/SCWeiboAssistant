//
//  SCNetworkManager.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 20/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire

class SCNetworkManager{
    static let shared = SCNetworkManager()
    lazy var userAccount = SCUserAccount()
    
    var userLogon: Bool{
        return userAccount.access_token != nil
    }
    private init() {
        
    }
    
    /// send request with token
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - method: get/ post
    ///   - params: parameters in dictionary
    ///   - completion: json(array/ dictionary), isSuccess
    func requestWithToken(urlString: String,method: HTTPMethod,params:[String:Any]?, completion:@escaping (_ list:Any?, _ isSuccess: Bool)->()){
        guard let token = userAccount.access_token else{
            // FIXME: no token exists send notification
            completion(nil,false)
            return
        }
        var params = params
        if params == nil{
            params = [String:Any]()
        }
        params?["access_token"] = token
        request(urlString: urlString, method: method, params: params) { (res, isSuccess, statusCode, _) in
            if statusCode == 403 {
                // FIXME: handle overdue token send notification
                completion(nil,false)
                return
            }
            completion(res,isSuccess)
        }
    }
    /// request method
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - method: get/ post
    ///   - params: parameters in dictionary
    ///   - completion: json(array/ dictionary), isSuccess, error
    func request(urlString:String, method:HTTPMethod, params:[String:Any]?, completion :@escaping (_ response: Any?,_ isSuccess: Bool, _ statusCode: Int,_ error: Error?)->() ){
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (dataResponse) in
            completion(
                dataResponse.result.value,
                dataResponse.result.isSuccess,
                dataResponse.response?.statusCode ?? 403,
                dataResponse.result.error)
        }
    }
}
