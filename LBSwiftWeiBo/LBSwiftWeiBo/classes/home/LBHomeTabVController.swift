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
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addRotationAnim()
//        if !isLogin {
//            return
//        }
        setupNavigationBar()
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
        popoVc.modalPresentationStyle = .custom
        present(popoVc, animated: true, completion: nil)
    }
}

extension LBHomeTabVController : UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return LBPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
