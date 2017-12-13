//
//  LBPresentationController.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/11.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBPresentationController: UIPresentationController {
    // 懒加载
    lazy var coverView : UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()

        // 设置弹出View的尺寸
       presentedView?.frame = CGRect(x: 100, y: 55, width: 180, height: 250)

        // 添加蒙版
        // setupCoverView()
    }
//    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
//        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
//        presentedView?.frame = CGRect(x: 100, y: 55, width: 180, height: 250)
//    }
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
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(LBPresentationController.coverViewClick))
        coverView.addGestureRecognizer(tapGes)
    }
}

extension LBPresentationController {
    @objc func coverViewClick() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
