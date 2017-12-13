//
//  LBPresentationController.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/11.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBPresentationController: UIPresentationController {
    var presentedFrame : CGRect = CGRect.zero
    
    // 懒加载属性
    lazy var coverView : UIView = UIView()
    
    // 系统回调函数
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 设置弹出View的尺寸
        presentedView?.frame = presentedFrame
        
        // 添加蒙版
        // setupCoverView()
    }
}

// 设置UI界面相关
extension LBPresentationController {
    func setupCoverView() {
        // 添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        
        // 设置蒙版的属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = containerView!.bounds
        
        // 添加手势
        let tapGes = UITapGestureRecognizer(target: self, action:#selector(LBPresentationController.coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}

extension LBPresentationController {
    @objc func coverViewClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
