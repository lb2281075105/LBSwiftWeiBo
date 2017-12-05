//
//  LBTabBarController.swift
//  LBSwiftWeiBo
//
//  Created by liubo on 2017/12/5.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBTabBarController: UITabBarController {

    // 懒加载属性
    private lazy var imageNames = ["tabbar_home", "tabbar_message_center", "", "tabbar_discover", "tabbar_profile"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 需要在viewWillAppear调整，不能在viewDidLoad调整
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for i in 0..<tabBar.items!.count {
            
            let item = tabBar.items![i]
            if i == 2 {
                item.isEnabled = false
                continue
            }
            item.selectedImage = UIImage(named: imageNames[i] + "_highlighted")
        }
    }

}
