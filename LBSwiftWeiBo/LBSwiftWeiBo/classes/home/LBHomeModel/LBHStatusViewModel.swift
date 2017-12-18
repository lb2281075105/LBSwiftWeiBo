//
//  LBHStatusViewModel.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/15.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit
// ------------------ 视图模型用来对model里面数据处理，是对model的简单封装 -------
class LBHStatusViewModel: NSObject {
    var status : LBHStatusModel?
    
    // 对数据处理的属性
    // 处理来源
    var sourceText : String?
    // 处理创建时间
    var createAtText : String?
    // 处理用户认证图标
    var verifiedImage : UIImage?
    // 处理用户会员等级
    var vipImage : UIImage?
    // 处理用户头像的地址
    var profileURL : NSURL?
    // 处理微博配图的数据
    var picURLs : [NSURL] = [NSURL]()
    // 自定义构造函数
    init(status : LBHStatusModel) {
        self.status = status
        
        // 对来源处理
        if let source = status.source,source != "" {
            // 获取起始位置和截取的长度
            let startIndex = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startIndex
            
            // 截取字符串
            sourceText = (source as NSString).substring(with: NSRange(location: startIndex, length: length))
        }
        
        // 处理时间
        if let createAt = status.created_at {
            createAtText = NSDate.createDateString(createAtStr: createAt)
        }
        
        // 处理认证
        let verifiedType = status.user?.verified_type ?? -1
        switch verifiedType {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            verifiedImage = nil
        }
        
        // 处理会员图标
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        // 用户配图
        if let picURLDicts = status.pic_urls {
            for picURLDict in picURLDicts {
                guard let picURLString = picURLDict["thumbnail_pic"] else {
                    continue
                }
                picURLs.append(NSURL(string: picURLString)!)
            }
        }
    }
}
