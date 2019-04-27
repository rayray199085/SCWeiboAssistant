//
//  SCStatusListViewModel.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 21/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import YYModel

private let maxPullUpErrorCount = 3
class SCStatusListViewModel{
    private lazy var pullUpErrorCount:Int = 0
    lazy var statusList = [SCStatusViewModel]()
    func loadStatus(isPullUp: Bool, completion:@escaping (_ isSuccess: Bool, _ shouldRefresh: Bool)->()){
        if isPullUp && pullUpErrorCount > maxPullUpErrorCount{
            completion(true, false)
            return
        }
        let since_id: Int64 = !isPullUp ? (statusList.first?.status.id ?? 0) : 0
        let max_id: Int64 = isPullUp ? (statusList.last?.status.id ?? 0) : 0
        SCNetworkManager.shared.getStatusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            if !isSuccess{
                completion(isSuccess,false)
                return
            }
            var statusViewModels = [SCStatusViewModel]()
            for dict in list ?? []{
                guard let model = SCStatus.yy_model(with: dict) else{
                    continue
                }
                statusViewModels.append(SCStatusViewModel(model: model))
            }
            if isPullUp && statusViewModels.count == 0{
                self.pullUpErrorCount += 1
                completion(isSuccess,false)
                return
            }
            if isPullUp{
                self.statusList += statusViewModels
            }else{
                self.statusList = statusViewModels + self.statusList
            }
            completion(isSuccess,true)
        }
    }
}
