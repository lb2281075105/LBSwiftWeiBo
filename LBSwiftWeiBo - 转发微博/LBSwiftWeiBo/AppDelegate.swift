//
//  AppDelegate.swift
//  LBSwiftWeiBo
//
//  Created by liubo on 2017/12/4.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // 在delegate中切换控制器
    var defaultController : UIViewController? {
        let isLogin = LBUserAViewModel.shareIntance.isLogin
        return isLogin ? LBWelcomeController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /// 设置全局一般在delegate里面
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange

//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = LBMainTabBarController()
//        window?.makeKeyAndVisible()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultController
        window?.makeKeyAndVisible()
        return true
    }

}

