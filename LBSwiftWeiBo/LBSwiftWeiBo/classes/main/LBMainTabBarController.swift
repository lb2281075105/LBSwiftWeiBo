//
//  LBMainTabBarController.swift
//  LBSwiftWeiBo
//
//  Created by liubo on 2017/12/4.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(childVc: LBHomeTabVController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(childVc: LBMessageTabVController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childVc: LBDiscoverTabVController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(childVc: LBProfileTabVController(), title: "我", imageName: "tabbar_profile")
    }
    private func addChildViewController(childVc: UIViewController, title : String, imageName : String) {
        
        /// 设置子控制器的属性
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        /// 设置导航栏控制器
        let childNav = UINavigationController(rootViewController: childVc)
        
        /// 添加控制器
        addChildViewController(childNav)
    }

}
