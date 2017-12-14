//
//  NSDate+Extension.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/14.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

extension NSDate {
    class func createDateString(createAtStr : String) -> String {
        // 创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        // 将字符串时间,转成NSDate类型
        guard let createDate = fmt.date(from: createAtStr) else {
            return ""
        }
        
        // 创建当前时间
        let nowDate = NSDate()
        
        // 计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        // 对时间间隔处理
        // 显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 9分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        // 1小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        // 创建日历对象
        let calendar = NSCalendar.current
        
        // 处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        let componentsSet = Set<Calendar.Component>([.year])
        // 处理一年之内: 02-22 12:22
        let cmps = calendar.dateComponents(componentsSet, from: createDate, to: nowDate as Date)
        
//        let cmps = calendar.component(.year, fromDate: createDate, toDate: nowDate, options: [])
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 超过一年: 2014-02-12 13:22
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr
    }
}
