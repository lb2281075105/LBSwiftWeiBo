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
    lazy var composeBtn : UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComposeBtn()
    }
    
    // 需要在viewWillAppear调整，不能在viewDidLoad调整
    // 也可以在storyboard添加选中图片，中间按钮并且设置不可点击也可以在storyboard中实现
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

extension LBTabBarController{

    func setupComposeBtn() {
        // 把composeBtn添加到tabbar中
        tabBar.addSubview(composeBtn)
        /*
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        composeBtn.sizeToFit()
        */
        // 设置位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        composeBtn.addTarget(self, action: #selector(LBTabBarController.composeBtnClick), for: .touchUpInside)

    }

}

extension LBTabBarController {

    @objc func composeBtnClick() {
        print("composeBtnClick")
    }
}

