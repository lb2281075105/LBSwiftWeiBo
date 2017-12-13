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
