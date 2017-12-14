//
//  LBUserAViewModel.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/14.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBUserAViewModel {
    
    // 将类设计成单例
    static let shareIntance : LBUserAViewModel = LBUserAViewModel()
    
    // 定义模型对象属性
    var account : LBUserAccount?
    
    // 计算属性
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("lbuserAccount.plist")
    }
    
    var isLogin : Bool {
        if account == nil {
            return false
        }
        
        guard let expiresDate = account?.expires_date else {
            return false
        }
        
        return expiresDate.compare(NSDate() as Date) == ComparisonResult.orderedDescending
    }
    
    // 重写init()函数
    init () {
        // 从沙盒中读取中归档的信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? LBUserAccount
    }
}
