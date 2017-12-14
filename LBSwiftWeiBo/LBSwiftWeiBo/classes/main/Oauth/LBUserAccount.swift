//
//  LBUserAccount.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/14.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBUserAccount: NSObject {
    // 授权AccessToken
    var access_token : String?
    // 过期时间-->秒
    var expires_in : TimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    // 用户ID
    var uid : String?
    // 过期日期
    var expires_date : NSDate?
    // 昵称
    var screen_name : String?
    // 用户的头像地址
    var avatar_large : String?
    // 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    // 重写description属性
    override var description: String{
        return dictionaryWithValues(forKeys: ["access_token", "expires_in", "uid"]).description
    }

}
