//
//  LBWelcomeController.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/14.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit
import SDWebImage
class LBWelcomeController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 获取用户头像
        let profileURLString = LBUserAViewModel.shareIntance.account?.avatar_large
        // ?? : 如果??前面的可选类型有值,那么将前面的可选类型进行解包并且赋值
        // 如果??前面的可选类型为nil,那么直接使用??后面的值
        // 赋值时候尽量使用??,在其他判断时候尽量使用guard else{}
        let url = NSURL(string: profileURLString ?? "")
        iconView.sd_setImage(with: url! as URL, placeholderImage: UIImage(named: "avatar_default_big"))
        
        // 改变约束的值
        iconViewBottomCons.constant = UIScreen.main.bounds.height - 300
        
        // 执行动画
        // initialSpringVelocity : 初始化速度
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: { () -> Void in
            self.view.layoutIfNeeded()
        }) { (_) -> Void in
            // 加载main.storyboard(
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }


}
