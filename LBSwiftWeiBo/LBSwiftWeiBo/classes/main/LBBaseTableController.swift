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
    }
}

extension LBBaseTableController {
    func setUpVisitorView() {
        view = visitorView
    }
}
