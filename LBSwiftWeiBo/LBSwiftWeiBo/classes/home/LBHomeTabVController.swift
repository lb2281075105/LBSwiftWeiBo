//
//  LBHomeTabVController.swift
//  LBSwiftWeiBo
//
//  Created by liubo on 2017/12/4.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBHomeTabVController: LBBaseTableController {
    lazy var titleBtn : LBTitleButton = LBTitleButton()
    lazy var popoverAnimator : LBPopoverAnimator = LBPopoverAnimator {[weak self] (presented) -> () in
        self?.titleBtn.isSelected = presented
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        setupNavigationBar()
        // 请求数据
        loadStatuses()
    }
}
extension LBHomeTabVController {
    func setupNavigationBar() {
        // 设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        
        // 设置右侧的Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 设置titleView
        titleBtn.setTitle("CodeJCSON", for: .normal)
        titleBtn.addTarget(self, action: #selector(LBHomeTabVController.titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

extension LBHomeTabVController {
    @objc func titleBtnClick(titleBtn : LBTitleButton) {
        titleBtn.isSelected = !titleBtn.isSelected
        
        // 弹出的控制器
        let popoVc = LBPopController()
        popoVc.transitioningDelegate = self
        // 保证下面控制器不被移除
        popoVc.modalPresentationStyle = .custom
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 100, width: 180, height: 250)
//        present(popoVc, animated: true, completion: nil)
    }
}

extension LBHomeTabVController : UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return LBPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension LBHomeTabVController{
    func loadStatuses() {
        LBNetWork.shareInstance.loadStatuses { (result, isSuccess) -> () in
            // 错误结果
            if isSuccess == false{
                print(isSuccess)
                return
            }
            
            // 获取可选类型中的数据
            guard let resultArray = result else {
                return
            }
            
            // 遍历微博对应的字典
            for statusDict in resultArray {
                print(statusDict)
            }
        }
    }
}
