//
//  LBUserAccount.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/14.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBUserAccount: NSObject,NSCoding{
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

    // 解档的方法
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
    }
    
    // 归档方法
    func encode(with aCoder: NSCoder){
        aCoder.encode(self.access_token, forKey: "access_token")
        aCoder.encode(self.uid, forKey: "uid")
        aCoder.encode(self.expires_date, forKey: "expires_date")
        aCoder.encode(self.avatar_large, forKey: "avatar_large")
        aCoder.encode(self.screen_name, forKey: "screen_name")
    }
    
}
