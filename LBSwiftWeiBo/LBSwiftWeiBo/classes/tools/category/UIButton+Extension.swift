//
//  UIButton.swift
//  LBSwiftWeiBo
//
//  Created by liubo on 2017/12/5.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

extension UIButton{
    /*
     convenience : 便利,使用convenience修饰的构造函数叫做便利构造函数
     遍历构造函数通常用在对系统的类进行构造函数的扩充时使用
     
     遍历构造函数的特点
     1.遍历构造函数通常都是写在extension里面
     2.遍历构造函数init前面需要加载convenience
     3.在遍历构造函数中需要明确的调用self.init()
     */
    convenience init (imageName : String, bgImageName : String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        // 设置UIButton的size和图片大小一样
        sizeToFit()
    }

}
