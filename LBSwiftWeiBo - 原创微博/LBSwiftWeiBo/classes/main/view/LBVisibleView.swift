//
//  LBVisibleView.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/7.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBVisibleView: UIView {
    // 图片旋转
    @IBOutlet weak var rotationView: UIImageView!
    /// 图标
    @IBOutlet weak var iconView: UIImageView!
    /// 文本
    @IBOutlet weak var tipLabel: UILabel!
    /// 注册按钮
    @IBOutlet weak var registerBtn: UIButton!
    /// 登录按钮
    @IBOutlet weak var loginBtn: UIButton!
    
    class func visitorView() -> LBVisibleView{
        return Bundle.main.loadNibNamed("LBVisibleView", owner: nil, options: nil)?.first as!LBVisibleView
    }

    func setUpVisitorViewInfo(iconName : String, title : String) {
        iconView.image = UIImage(named: iconName)
        tipLabel.text = title
        rotationView.isHidden = true
    }
    
    func addRotationAnim() {
        // 创建Z轴动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 设置动画的属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        
        // 将动画添加到layer中
        rotationView.layer.add(rotationAnim, forKey: nil)
    }
}
