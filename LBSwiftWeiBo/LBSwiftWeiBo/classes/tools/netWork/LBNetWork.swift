//
//  LBNetWork.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/13.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit
import AFNetworking
enum HTTPRequestType : String{
    case GET = "GET"
    case POST = "POST"
}
class LBNetWork: AFHTTPSessionManager {
    // 第一种单利
    static let shareInstance : LBNetWork = {
        let tools = LBNetWork()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
    }()
    // 第二种单利
    // static let shareInstance : LBNetWork = LBNetWork()
}

extension LBNetWork{
    
    // 封装GET和POST 请求
    //  - Parameters:
    //  - requestType: 请求方式
    //  - urlString: urlString
    //  - parameters: 字典参数
    //  - completion: 回调
    func request(requestType: HTTPRequestType, urlString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: AnyObject?,_ isSuccess: Bool) -> ()) {
        
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
            print("请求成功")
            completion(json as AnyObject?,true)
        }
        
        // 失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error)")
            completion(nil,false)
        }
        
        if requestType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
}
extension LBNetWork {
    func loadAccessToken(code : String, completion : @escaping (_ result : [String : AnyObject]?,_ isSuccess : Bool) -> ()) {
        // 获取请求的URLString
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        // 获取请求的参数
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : "authorization_code", "redirect_uri" : redirect_uri, "code" : code]
        
        // 发送网络请求
        request(requestType: .POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, isSuccess) in
            completion(result as? [String : AnyObject], isSuccess)
        }
    }
}
// 请求用户的信息
extension LBNetWork {
    func loadUserInfo(access_token : String, uid : String, completion : @escaping (_ result : [String : AnyObject]?,_ isSuccess : Bool) -> ()) {
        // 获取请求的URLString
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        // 获取请求的参数
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        // 发送网络请求
        request(requestType: .GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, isSuccess) -> () in
            completion(result as? [String : AnyObject] , isSuccess)
        }
    }
}
