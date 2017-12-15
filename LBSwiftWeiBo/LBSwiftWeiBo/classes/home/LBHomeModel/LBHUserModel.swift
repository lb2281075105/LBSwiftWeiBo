//
//  LBHUserModel.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/15.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBHUserModel: NSObject {
    // 用户的头像
    var profile_image_url : String?
    // 用户的昵称
    var screen_name : String?
    // 用户的认证类型
    var verified_type : Int = -1
    // 用户的会员等级
    var mbrank : Int = 0
    
    // 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
