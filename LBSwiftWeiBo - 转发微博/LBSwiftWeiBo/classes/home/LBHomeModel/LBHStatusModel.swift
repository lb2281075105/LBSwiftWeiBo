//
//  LBHStatusModel.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/14.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBHStatusModel: NSObject {
    // 微博创建时间
    var created_at : String?
    // 微博来源
    var source : String?
    // 微博的正文
    var text : String?
    // 微博的ID
    var mid : Int = 0
    // 用户model
    var user : LBHUserModel?
    // 用户微博的配图
    var pic_urls : [[String : String]]?
    
    // mark - 转发微博model -- 微博对应的转发的微博
    var retweeted_status : LBHStatusModel?
    // 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
        // 1、将用户字典转成用户模型对象
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = LBHUserModel(dict: userDict)
        }
        // mark - 2、将转发微博字典转成转发微博模型对象
        if let retweetedStatusDict = dict["retweeted_status"] as? [String : AnyObject] {
            retweeted_status = LBHStatusModel(dict: retweetedStatusDict)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
