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
        print(LBHomeTabVController())
//        addChildViewController(childVc: LBHomeTabVController(), title: "首页", imageName: "tabbar_home")
//        addChildViewController(childVc: LBMessageTabVController(), title: "消息", imageName: "tabbar_message_center")
//        addChildViewController(childVc: LBDiscoverTabVController(), title: "发现", imageName: "tabbar_discover")
//        addChildViewController(childVc: LBProfileTabVController(), title: "我", imageName: "tabbar_profile")
        addChildViewController(childVcStr: "LBHomeTabVController", title: "首页", imageName: "tabbar_home")
        addChildViewController(childVcStr: "LBMessageTabVController", title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childVcStr: "LBDiscoverTabVController", title: "发现", imageName: "tabbar_discover")
        addChildViewController(childVcStr: "LBProfileTabVController", title: "我", imageName: "tabbar_profile")
    }
    private func addChildViewController(childVcStr: String, title : String, imageName : String) {
        
        // 注意：如果用字符串拿到对应的控制器，<LBSwiftWeiBo.LBHomeTabVController: 0x7ff876c06c80>
        // 那就需要在控制器名之前加上项目名字LBSwiftWeiBo + . +LBHomeTabVController，NSClassFromString("LBSwiftWeiBo.LBHomeTabVController")
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else{
            print("没有获取命名空间")
            return
        }
        
        guard let childVcClass = NSClassFromString(nameSpace + "." + childVcStr) else {
            print("没有获取到字符串对应的Class")
            return
        }
        
        guard let childClass = childVcClass as? UIViewController.Type  else {
            return
        }
        
        /// 创建控制器对象
        let childVc = childClass.init()
        
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
