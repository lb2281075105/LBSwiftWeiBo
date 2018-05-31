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
        /*
        1、第一种创建标签栏的方式：通过创建控制器来创建标签栏
        print(LBHomeTabVController())
        addChildViewController(childVc: LBHomeTabVController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(childVc: LBMessageTabVController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childVc: LBDiscoverTabVController(), title: "发现", imageName: "tabbar_discover")
        addChildViewController(childVc: LBProfileTabVController(), title: "我", imageName: "tabbar_profile")
        */
        /*
        2、第二种创建标签栏的方式：使用字符串拿到对应的控制器，这里用到命名空间的概念
        addChildViewController(childVcStr: "LBHomeTabVController", title: "首页", imageName: "tabbar_home")
        addChildViewController(childVcStr: "LBMessageTabVController", title: "消息", imageName: "tabbar_message_center")
        addChildViewController(childVcStr: "LBDiscoverTabVController", title: "发现", imageName: "tabbar_discover")
        addChildViewController(childVcStr: "LBProfileTabVController", title: "我", imageName: "tabbar_profile")
        */
        /*
        3、通过第三种创建标签栏的方式：json文件创建，这种创建好处就是可以根据服务器返回来的数据相应的控制标签按钮的个数
         */
        let jsonPath = Bundle.main.path(forResource: "LBMainTabBarSettings.json", ofType: nil)
        guard let jsonPathString = jsonPath else {
            return
        }
        // 通过文件路径获取二进制数据
        guard let jsonData = NSData(contentsOfFile: jsonPathString) else {
            return
        }
        // jsonData as Data 把OC对象转换成Swift对象
        /*
         常用方式处理抛出来的异常
         try?方式:系统帮助我们处理异常,如果该方法出现了异常,则该方法返回nil.如果没有异常,则返回对应的对象
         guard let anyObject = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) else {
         return
         }
        */
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {
            return
        }
        
        guard let dictArray = anyObject as? [[String : AnyObject]] else {
            return
        }
        
        // 遍历字典,获取对应的信息
        for dict in dictArray {
            // print(dict)
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            
            guard let title = dict["title"] as? String else {
                continue
            }
            
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
            
            addChildViewController(childVcStr: vcName, title: title, imageName: imageName)
        }
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
        
        // 创建控制器对象
        let childVc = childClass.init()
        
        // 设置子控制器的属性
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 设置导航栏控制器
        let childNav = UINavigationController(rootViewController: childVc)
        
        /// 添加控制器
        addChildViewController(childNav)
    }

}
