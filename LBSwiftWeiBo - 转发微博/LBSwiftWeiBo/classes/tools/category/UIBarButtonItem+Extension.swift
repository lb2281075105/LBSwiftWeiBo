//
//  UIBarButtonItem+Extension.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/11.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
   convenience init(imageName : String) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView : btn)
    }
}
