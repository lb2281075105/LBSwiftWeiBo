//
//  UIButton.swift
//  LBSwiftWeiBo
//
//  Created by liubo on 2017/12/5.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

extension UIButton{
    
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
