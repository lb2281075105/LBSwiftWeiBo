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
    
    // 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
