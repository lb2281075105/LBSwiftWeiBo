//
//  LBBaseTableController.swift
//  LBSwiftWeiBo
//
//  Created by yunmei on 2017/12/7.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBBaseTableController: UITableViewController {
    // 懒加载
    lazy var visitorView : LBVisibleView = LBVisibleView.visitorView()
    var isLogin : Bool = false
    override func loadView() {
        isLogin ? super.loadView() : setUpVisitorView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
    }
}

extension LBBaseTableController {
    func setUpVisitorView() {
        view = visitorView
        
        visitorView.registerBtn.addTarget(self, action: #selector(LBBaseTableController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(LBBaseTableController.loginBtnClick), for: .touchUpInside)
    }
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(LBBaseTableController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(LBBaseTableController.loginBtnClick))
    }
}

extension LBBaseTableController {
    // 注册
    @objc func registerBtnClick() {
        print("registerBtnClick")
    }
    // 登录
    @objc func loginBtnClick() {
        print("loginBtnClick")
    }
}
