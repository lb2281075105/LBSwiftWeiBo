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
    var created_at : String?{
        didSet {
            // nil值校验
            guard let created_at = created_at else {
                return
            }
            
            // 对时间处理
            createAtText = NSDate.createDateString(createAtStr: created_at)
        }
    }
    // 微博来源
    var source : String?{
        didSet {
            // nil值校验
            // guard let source = source, source != "" else {} 逗号用来判断条件需要同时满足
            guard let source = source, source != "" else {
                return
            }
            
            // 对来源的字符串进行处理
            // 获取起始位置和截取的长度
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            // 截取字符串
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
    }
    // 微博的正文
    var text : String?
    // 微博的ID
    var mid : Int = 0
    // 对数据处理的属性
    var sourceText : String?
    var createAtText : String?
    // 自定义构造函数
    init(dict : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
